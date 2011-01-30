package com.soma.core.mediator {
	import com.soma.core.interfaces.IMediator;
	import com.soma.core.interfaces.ISoma;
	import com.soma.core.interfaces.ISomaInjector;

	import flash.events.Event;
	import flash.utils.Dictionary;
	/**
	 * @author Romuald Quantin
	 */
	public class SomaMediators {

		private var _instance:ISoma;
		private var _injector:ISomaInjector;
		
		private var _classes:Dictionary;		private var _mediators:Dictionary;
		
		public function SomaMediators(instance:ISoma) {
			_instance = instance;
			initialize();
		}

		private function initialize():void {
			if (_instance.injector) _injector = _instance.injector.createChildInjector();
			_classes = new Dictionary();
			_mediators = new Dictionary(true);
			_instance.stage.addEventListener(Event.ADDED_TO_STAGE, addedhandler, true, 0, true);
			_instance.stage.addEventListener(Event.REMOVED_FROM_STAGE, removedhandler, true, 0, true);
		}
		
		private function getClassFromInstance(value:Object):Class {
			return _instance.reflector.getClass(value);
		}

		private function getClassName(value:Object):String {
			return _instance.reflector.getFQCN(value);
		}

		private function addedhandler(event:Event):void {
			var viewClassName:String = getClassName(event.target);
			if (_classes[viewClassName]) {
				createMediator(event.target, getClassFromInstance(event.target), _classes[viewClassName]);
			}
		}

		private function removedhandler(event:Event):void {
			disposeMediator(event.target);
		}
		
		private function createMediator(view:Object, viewClass:Class, mediatorClass:Class):void {
			if (_classes[getClassName(view)] && !_mediators[view]) {
				var mediator:IMediator;
				if (_injector) {
					_injector.mapToInstance(viewClass, view);
					mediator = IMediator(_injector.createInstance(mediatorClass));
					_injector.removeMapping(viewClass);
				}
				else {
					mediator = new mediatorClass();
					mediator.instance = _instance;
				}
				_mediators[view] = mediator;
				view.addEventListener("creationComplete", creationComplete, false, 0, true);
				mediator.viewComponent = view;
				mediator.initialize();
			}
		}

		private function disposeMediator(view:Object):void {
			if (_mediators[view]) {
				view.removeEventListener("creationComplete", creationComplete, false);
				IMediator(_mediators[view]).dispose();
				IMediator(_mediators[view]).viewComponent = null;
				IMediator(_mediators[view]).instance = null;
				_mediators[view] = null;
				delete _mediators[view];
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
			for each (var mediator:IMediator in _mediators) {
				mediator.dispose();
			}
			_classes = null;
			_mediators = null;
			_instance = null;
			_injector = null;
		}
		
		public function hasMediator(view:Object):Boolean {
			return (_mediators[view] != null || _mediators[view] != undefined);
		}
		
		public function getMediatorByView(view:Object):IMediator {
			return _mediators[view];
		}
		
		public function isMapped(viewClass:Class):Boolean {
			return (_classes[getClassName(viewClass)] != undefined);
		}
		
		public function mapView(viewClass:Class, mediatorClass:Class):void {
			if (!viewClass || !mediatorClass) return;
			if (isMapped(viewClass)) {
				throw new Error("Error in " + this + " View Class (mapView method) \"" + viewClass + "\" already mapped.");
			}
			var viewClassName:String = getClassName(viewClass);
			_classes[viewClassName] = mediatorClass;
		}
		
		public function removeMapping(viewOrInterface:Class):void {
			if (!viewOrInterface) return;
			if (!isMapped(viewOrInterface)) {
				throw new Error("Error in " + this + " View or Interface Class (unmap method) \"" + viewOrInterface + "\" not mapped.");
			}
			if (_classes[getClassName(viewOrInterface)]) {
				_classes[getClassName(viewOrInterface)] = null;
				delete _classes[viewOrInterface];
			}
		}
		
	}
}
