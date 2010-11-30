package com.soma.core.mediator {
	import com.soma.core.interfaces.ISomaInjector;
	import com.soma.core.interfaces.IMediator;
	import com.soma.core.interfaces.ISoma;

	import flash.events.Event;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	/**
	 * @author Romuald Quantin
	 */
	public class SomaMediators {

		private var _instance:ISoma;
		private var _injector:ISomaInjector;
		private var _mediatorsByClass:Dictionary;
		private var _mediatorsByInstance:Dictionary;

		public function SomaMediators(instance:ISoma) {
			_instance = instance;
			initialize();
		}

		private function initialize():void {
			if (_instance.injector) _injector = _instance.injector;//_instance.injector.createChildInjector();
			_mediatorsByClass = new Dictionary();
			_mediatorsByInstance = new Dictionary();
			_instance.stage.addEventListener(Event.ADDED_TO_STAGE, addedhandler, true, 0, true);
			_instance.stage.addEventListener(Event.REMOVED_FROM_STAGE, removedhandler, true, 0, true);
		}
		
		private function getClassFromInstance(value:Object):Class {
			return getDefinitionByName(getQualifiedClassName(value)) as Class;
		}

		private function addedhandler(event:Event):void {
			createMediator(event.target, getClassFromInstance(event.target));
		}

		private function removedhandler(event:Event):void {
			disposeMediator(event.target);
		}
		
		private function createMediator(view:Object, viewClass:Class):void {
			if (_mediatorsByClass[viewClass] && !_mediatorsByInstance[view]) {
				var mediator:IMediator;
				if (_injector) {
					_injector.mapToInstance(viewClass, view);
					mediator = IMediator(_injector.createInstance(_mediatorsByClass[viewClass]));
					_injector.removeMapping(viewClass);
				}
				else {
					mediator = new _mediatorsByClass[viewClass]();
					mediator.instance = _instance;
				}
				_mediatorsByInstance[view] = mediator;
				view.addEventListener("creationComplete", creationComplete, false, 0, true);
				mediator.viewComponent = view;
				mediator.initialize();
			}
		}

		private function disposeMediator(view:Object):void {
			if (_mediatorsByInstance[view]) {
				view.removeEventListener("creationComplete", creationComplete, false);
				IMediator(_mediatorsByInstance[view]).dispose();
				IMediator(_mediatorsByInstance[view]).viewComponent = null;
				IMediator(_mediatorsByInstance[view]).instance = null;
				_mediatorsByInstance[view] = null;
				delete _mediatorsByInstance[view];
			}
		}
		
		private function creationComplete(event:Event):void {
			event.target.removeEventListener("creationComplete", creationComplete);
			var mediator:IMediator = getMediatorByView(event.target);
			if (mediator && Object(mediator).hasOwnProperty("creationComplete")) {
				Object(mediator).creationComplete();
			}
		}

		public function dispose():void {
			_instance.stage.removeEventListener(Event.ADDED_TO_STAGE, addedhandler, true);
			_instance.stage.removeEventListener(Event.REMOVED_FROM_STAGE, removedhandler, true);
			for each (var mediator:IMediator in _mediatorsByInstance) {
				mediator.dispose();
			}
			_mediatorsByClass = null;
			_mediatorsByInstance = null;
		}
		
		public function hasMediator(view:Object):Boolean {
			return (_mediatorsByInstance[view] != null || _mediatorsByInstance[view] != undefined);
		}
		
		public function getMediatorByView(view:Object):IMediator {
			return _mediatorsByInstance[view];
		}
		
		public function isMapped(viewClass:Class):Boolean {
			return (_mediatorsByClass[viewClass] != null && _mediatorsByClass[viewClass] != undefined);
		}
		
		public function mapView(viewClass:Class, mediatorClass:Class):void {
			if (!viewClass || !mediatorClass) return;
			if (isMapped(viewClass)) {
				throw new Error("Error in " + this + " View Class (map method) \"" + viewClass + "\" already mapped.");
			}
			_mediatorsByClass[viewClass] = mediatorClass;
		}
		
		public function unmapView(viewClass:Class):void {
			if (!viewClass) return;
			if (!isMapped(viewClass)) {
				throw new Error("Error in " + this + " View Class (unmap method) \"" + viewClass + "\" not mapped.");
			}
			_mediatorsByClass[viewClass] = null;
			delete _mediatorsByClass[viewClass];
		}
		
	}
}
