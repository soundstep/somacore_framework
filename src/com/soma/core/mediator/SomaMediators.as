package com.soma.core.mediator {
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
		private var _mediatorsByClass:Dictionary;
		private var _mediatorsByInstance:Dictionary;

		public function SomaMediators(instance:ISoma) {
			_instance = instance;
			initialize();
		}

		private function initialize():void {
			_mediatorsByClass = new Dictionary();
			_mediatorsByInstance = new Dictionary();
			_instance.stage.addEventListener(Event.ADDED_TO_STAGE, addedhandler, true, 0);
			_instance.stage.addEventListener(Event.REMOVED_FROM_STAGE, removedhandler, true, 0);
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
			if (_mediatorsByClass[viewClass]) {
				_instance.injector.mapToInstance(viewClass, view);
				var mediator:IMediator = IMediator(_instance.injector.createInstance(_mediatorsByClass[viewClass]));
				mediator.viewComponent = view;
				mediator.instance = _instance;
				_instance.injector.removeMapping(viewClass);
				_mediatorsByInstance[view] = mediator;
			}
		}

		private function disposeMediator(view:Object):void {
			if (_mediatorsByInstance[view]) {
				IMediator(_mediatorsByInstance[view]).dispose();
				_mediatorsByInstance[view] = null;
				delete _mediatorsByInstance[view];
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
