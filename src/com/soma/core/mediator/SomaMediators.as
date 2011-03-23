package com.soma.core.mediator {
	import com.soma.core.interfaces.IMediator;
	import com.soma.core.interfaces.ISoma;
	import com.soma.core.interfaces.ISomaInjector;

	import flash.events.Event;
	import flash.utils.Dictionary;
	
	/**
	 * <p><b>Author:</b> Romuald Quantin - <a href="http://www.soundstep.com/" target="_blank">www.soundstep.com</a></p>
	 * <p><b>Resources:</b> <a href="http://www.soundstep.com/downloads/somacore" target="_blank">http://www.soundstep.com/downloads/somacore</a></p>
	 * <p><b>Actionscript version:</b> 3.0</p>
	 * <p><b>Copyright:</b>
	 * Mozilla Public License 1.1 (MPL 1.1)<br /> 
	 * <a href="http://www.opensource.org/licenses/mozilla1.1.php" target="_blank">http://www.opensource.org/licenses/mozilla1.1.php</a></p>
	 * The SomaMediators class handles the mediators of the application. See the Mediator class documentation for implementation. 
	 * @see com.soma.core.mediator.Mediator
	 */
	
	public class SomaMediators {
		
		/** @private */
		private var _instance:ISoma;
		/** @private */
		private var _injector:ISomaInjector;
		/** @private */
		private var _classes:Dictionary;
		/** @private */
		private var _mediators:Dictionary;
		
		/**
		 * Create an instance of the SomaWires class. Should not be directly instantiated, the framework will instantiate the class.
		 * @param instance Framework instance.
		 */
		public function SomaMediators(instance:ISoma) {
			_instance = instance;
			initialize();
		}
		
		/** @private */
		private function initialize():void {
			if (_instance.injector) _injector = _instance.injector.createChildInjector();
			_classes = new Dictionary();
			_mediators = new Dictionary(true);
			_instance.stage.addEventListener(Event.ADDED_TO_STAGE, addedhandler, true, 0, true);
			_instance.stage.addEventListener(Event.REMOVED_FROM_STAGE, removedhandler, true, 0, true);
		}
		
		/** @private */
		private function getClassFromInstance(value:Object):Class {
			return _instance.reflector.getClass(value);
		}
		
		/** @private */
		private function getClassName(value:Object):String {
			return _instance.reflector.getFQCN(value);
		}
		
		/** @private */
		private function addedhandler(event:Event):void {
			var viewClassName:String = getClassName(event.target);
			if (_classes[viewClassName]) {
				createMediator(event.target, getClassFromInstance(event.target), _classes[viewClassName]);
			}
		}
		
		/** @private */
		private function removedhandler(event:Event):void {
			disposeMediator(event.target);
		}
		
		/** @private */
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
		
		/** @private */
		private function disposeMediator(view:Object):void {
			view.removeEventListener("creationComplete", creationComplete, false);
			if (_mediators[view]) {
				IMediator(_mediators[view]).dispose();
				IMediator(_mediators[view]).viewComponent = null;
				IMediator(_mediators[view]).instance = null;
				_mediators[view] = null;
				delete _mediators[view];
			}
		}
		
		/** @private */
		private function creationComplete(event:Event):void {
			event.target.removeEventListener("creationComplete", creationComplete);
			var mediator:IMediator = getMediatorByView(event.target);
			if (mediator && Object(mediator).hasOwnProperty("creationComplete")) {
				Object(mediator).creationComplete();
			}
		}
		
		/**
		 * Destroys all the mediators and properties. The class will call the dispose method of each mediator instance.
		 */
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
		
		/**
		 * Indicates wether a mediator has been created by the framework for a specific view.
		 * @param view View that the mediator represents.
		 * @return A Boolean.
		 * @example
		 * <listing version="3.0">mediators.hasMediator(myView);</listing>
		 */
		public function hasMediator(view:Object):Boolean {
			return (_mediators[view] != null || _mediators[view] != undefined);
		}
		
		/**
		 * Retrieves a mediator instance using its view.
		 * @param view View that the mediator represents.
		 * @return A mediator instance.
		 * @example
		 * <listing version="3.0">var mediator:MyViewMediator = mediators.getMediatorByView(myView) as MyViewMediator;</listing>
		 */
		public function getMediatorByView(view:Object):IMediator {
			return _mediators[view];
		}
		
		/**
		 * Indicates wether a view Class has a mapping rule.
		 * @param viewClass A Class.
		 * @return A Boolean.
		 * @example
		 * <listing version="3.0">mediators.isMapped(MyView);</listing>
		 */
		public function isMapped(viewClass:Class):Boolean {
			return (_classes[getClassName(viewClass)] != undefined);
		}
		
		/**
		 * Map a mediator Class to a view Class.
		 * @param viewClass A Class.
		 * @param mediatorClass A Class.
		 * @return A Boolean.
		 * @example
		 * <listing version="3.0">mediators.mapView(MyView, MyViewMediator);</listing>
		 */
		public function mapView(viewClass:Class, mediatorClass:Class):void {
			if (!viewClass || !mediatorClass) return;
			if (isMapped(viewClass)) {
				throw new Error("Error in " + this + " View Class (mapView method) \"" + viewClass + "\" already mapped.");
			}
			var viewClassName:String = getClassName(viewClass);
			_classes[viewClassName] = mediatorClass;
		}
		
		/**
		 * Remove a mapping rule for a specific Class.
		 * @param viewClass A Class.
		 * @return A Boolean.
		 * @example
		 * <listing version="3.0">mediators.removeMapping(MyView);</listing>
		 */
		public function removeMapping(viewClass:Class):void {
			if (!viewClass) return;
			if (!isMapped(viewClass)) {
				throw new Error("Error in " + this + " View Class (unmap method) \"" + viewClass + "\" not mapped.");
			}
			if (_classes[getClassName(viewClass)]) {
				_classes[getClassName(viewClass)] = null;
				delete _classes[viewClass];
			}
		}
		
	}
}
