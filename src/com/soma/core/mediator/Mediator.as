package com.soma.core.mediator {
	import com.soma.core.interfaces.IMediator;
	import com.soma.core.wire.Wire;

	/**
	 * @author Romuald Quantin
	 */
	public class Mediator extends Wire implements IMediator {
		
		protected var _viewComponent:Object;
		
		public function Mediator(name:String = null) {
			super(name);
		}
		
		public final function get viewComponent():Object {
			return _viewComponent;
		}
		
		public final function set viewComponent(value:Object):void {
			_viewComponent = value;
		}
		
		override public function postConstruct():void { /* removes post construct from super class (the mediator is initialized manually) */}
		
		public function creationComplete():void {
			
		}
		
	}
}
