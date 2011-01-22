package com.soma.core.mediator {
	import com.soma.core.interfaces.IMediator;
	import com.soma.core.interfaces.ISoma;
	import com.soma.core.interfaces.ISomaInjector;
	
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
		private var _mediatorClasses:Dictionary;		private var _mediatorViews:Dictionary;

		public function SomaMediators(instance:ISoma) {
			_instance = instance;
			initialize();
		}

		private function initialize():void {
			if (_instance.injector) _injector = _instance.injector.createChildInjector();
			_mediatorClasses = new Dictionary();
			_mediatorViews = new Dictionary();
			_instance.stage.addEventListener(Event.ADDED_TO_STAGE, addedhandler, true, 0, true);
			_instance.stage.addEventListener(Event.REMOVED_FROM_STAGE, removedhandler, true, 0, true);
		}
		
		private function getClassFromInstance(value:Object):Class {
			return Class(getDefinitionByName(getQualifiedClassName(value)));
		}

		private function getClassName(value:Object):String {
			return getQualifiedClassName(value);
		}

		private function addedhandler(event:Event):void {
			if (!_mediatorClasses[getClassName(event.target)]) return;
			createMediator(event.target, getClassFromInstance(event.target));
		}

		private function removedhandler(event:Event):void {
			disposeMediator(event.target);
		}
		
		private function createMediator(view:Object, viewClass:Class):void {
			if (_mediatorClasses[getClassName(view)] && !_mediatorViews[view]) {
				var mediator:IMediator;
				if (_injector) {
					_injector.mapToInstance(viewClass, view);
					mediator = IMediator(_injector.createInstance(_mediatorClasses[getClassName(view)]));
					_injector.removeMapping(viewClass);
				}
				else {
					mediator = new _mediatorClasses[getClassName(view)]();
					mediator.instance = _instance;
				}
				_mediatorViews[view] = mediator;
				view.addEventListener("creationComplete", creationComplete, false, 0, true);
				mediator.viewComponent = view;
				mediator.initialize();
			}
		}

		private function disposeMediator(view:Object):void {
			if (_mediatorViews[view]) {
				view.removeEventListener("creationComplete", creationComplete, false);
				IMediator(_mediatorViews[view]).dispose();
				IMediator(_mediatorViews[view]).viewComponent = null;
				IMediator(_mediatorViews[view]).instance = null;
				_mediatorViews[view] = null;
				delete _mediatorViews[view];
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
			for each (var mediator:IMediator in _mediatorViews) {
				mediator.dispose();
			}
			_mediatorClasses = null;
			_mediatorViews = null;
		}
		
		public function hasMediator(view:Object):Boolean {
			return (_mediatorViews[view] != null || _mediatorViews[view] != undefined);
		}
		
		public function getMediatorByView(view:Object):IMediator {
			return _mediatorViews[view];
		}
		
		public function isMapped(viewClass:Class):Boolean {
			var className:String = getClassName(viewClass);
			return (_mediatorClasses[className] != null && _mediatorClasses[className] != undefined);
		}
		
		public function mapView(viewClass:Class, mediatorClass:Class):void {
			if (!viewClass || !mediatorClass) return;
			if (isMapped(viewClass)) {
				throw new Error("Error in " + this + " View Class (map method) \"" + viewClass + "\" already mapped.");
			}
			_mediatorClasses[getClassName(viewClass)] = mediatorClass;
		}
		
		public function unmapView(viewClass:Class):void {
			if (!viewClass) return;
			if (!isMapped(viewClass)) {
				throw new Error("Error in " + this + " View Class (unmap method) \"" + viewClass + "\" not mapped.");
			}
			_mediatorClasses[getClassName(viewClass)] = null;
			delete _mediatorClasses[viewClass];
		}
		
	}
}

class MediatorMapping {
	public var mediatorClassName:String;	public var mediatorClass:Class;
	public function MediatorMapping(mediatorClassName:String, mediatorClass:Class) {
		this.mediatorClassName = mediatorClassName;		this.mediatorClass = mediatorClass;
	}
}
