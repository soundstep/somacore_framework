package com.soma.core.interfaces {

	import com.soma.core.interfaces.IWire;

	/**
	 * @author Romuald Quantin
	 */
	public interface IMediator extends IWire {
		
		/**
		 * View that has been mapped to the mediator instance.
		 */
		function get viewComponent():Object;
		function set viewComponent(value:Object):void;
		
	}
}
