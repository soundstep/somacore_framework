package com.soma.core.interfaces {

	import com.soma.core.interfaces.IWire;

	/**
	 * @author Romuald Quantin
	 */
	public interface IMediator extends IWire {
		
		function get viewComponent():Object;
		function set viewComponent(value:Object):void;
		
	}
}
