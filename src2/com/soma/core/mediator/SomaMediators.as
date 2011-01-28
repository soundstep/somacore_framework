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
		
		private var _interfacesDictionary:Dictionary;
		private var _interfacesArray:Array;
		
		private var _allowInterfaceMapping:Boolean = true;
		
		public function SomaMediators(instance:ISoma) {
			_instance = instance;
			initialize();
		}

		private function initialize():void {
			if (_instance.injector) _injector = _instance.injector.createChildInjector();
			_classes = new Dictionary();
			_mediators = new Dictionary(true);
			_interfacesDictionary = new Dictionary();
			_interfacesArray = [];
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
			if (!_allowInterfaceMapping) return;
			if (_interfacesArray.length == 0) return;
			var i:Number = _interfacesArray.length;
			while (i > 0) {
				--i;
				if (event.target is _interfacesArray[i]) {
					createMediator(event.target, getClassFromInstance(event.target), _interfacesDictionary[_interfacesArray[i]], _interfacesArray[i]);
				}
			}
		}

		private function removedhandler(event:Event):void {
			disposeMediator(event.target);
		}
		
		private function createMediator(view:Object, viewClass:Class, mediatorClass:Class, interfaceClass:Class = null):void {
			if (_mediators[view] && !interfaceClass) return;
			var mediator:IMediator;
			if (_injector) {
				_injector.mapToInstance(viewClass, view);
				if (interfaceClass && !_injector.hasMapping(interfaceClass)) {
					_injector.mapToInstance(interfaceClass, view);
				}
				mediator = IMediator(_injector.createInstance(mediatorClass));
				_injector.removeMapping(viewClass);
				if (interfaceClass) {
					_injector.removeMapping(interfaceClass);
				}
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
			var className:String = getClassName(viewClass);
			return (_classes[className] != undefined && _interfacesDictionary[viewClass] != undefined);
		}
		
		public function map(viewOrInterface:Class, mediatorClass:Class):void {
			if (!viewOrInterface || !mediatorClass) return;
			if (isMapped(viewOrInterface)) {
				throw new Error("Error in " + this + " View or Interface Class (map method) \"" + viewOrInterface + "\" already mapped.");
			}
			var viewClassName:String = getClassName(viewOrInterface);
			_classes[viewClassName] = mediatorClass;
			if (!_allowInterfaceMapping) return;
			try {
				new viewOrInterface();
			} catch(e:Error) {
				if (e is VerifyError) {
					_interfacesDictionary[viewOrInterface] = mediatorClass;
					_interfacesArray[_interfacesArray.length] = viewOrInterface;
				}
			}
		}
		
		public function unmap(viewOrInterface:Class):void {
			if (!viewOrInterface) return;
			if (!isMapped(viewOrInterface)) {
				throw new Error("Error in " + this + " View or Interface Class (unmap method) \"" + viewOrInterface + "\" not mapped.");
			}
			if (_classes[getClassName(viewOrInterface)]) {
				_classes[getClassName(viewOrInterface)] = null;
				delete _classes[viewOrInterface];
			}
			if (_interfacesDictionary[viewOrInterface] != undefined) {
				_interfacesDictionary[viewOrInterface] = null;
				delete _interfacesDictionary[viewOrInterface];
				var i:Number = _interfacesArray.length;
				while (i > 0) {
					--i;
					if (_interfacesArray[i] == viewOrInterface) {
						_interfacesArray.splice(i, 1);
						break;
					}
				}
			}
		}

		public function get allowInterfaceMapping():Boolean {
			return _allowInterfaceMapping;
		}

		public function set allowInterfaceMapping(value:Boolean):void {
			_allowInterfaceMapping = value;
		}
		
	}
}

class InterfaceMapping {
	public var interfaceClass:Class;
	public var mediatorClass:Class;
	public function InterfaceMapping(interfaceClass:Class, mediatorClass:Class) {
		this.interfaceClass = interfaceClass;
		this.mediatorClass = mediatorClass;
	}
}
