package com.soma.core.interfaces {
	import flash.events.IEventDispatcher;

	/**
	 * <b>Author:</b> Romuald Quantin - <a href="http://www.soundstep.com/" target="_blank">www.soundstep.com</a><br />* <b>Class version:</b> 1.0<br />
	 * <b>Actionscript version:</b> 3.0<br />
	 * <b>Copyright:</b> 
	 * <br />
	 * <b>Date:</b> Sep 17, 2009<br />
	 * <b>Usage:</b>
	 * @example
	 * <listing version="3.0"></listing>
	 */
	
	public interface IModel {

		function get name():String;
		function set name(value:String):void;
		function get data():Object;
		function set data(value:Object):void;
		function get dispatcher():IEventDispatcher;
		
	}
}