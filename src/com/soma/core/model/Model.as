package com.soma.core.model {
	import com.soma.core.interfaces.IModel;

	import flash.events.Event;
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
	
	public class Model implements IModel {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		namespace somans = "http://www.soundstep.com/soma";
		
		private var _dispatcher:IEventDispatcher;
		protected var _data:Object;
		protected var _name:String;

		//------------------------------------
		// public properties
		//------------------------------------
		
		public static var NAME:String = "Soma::Model";
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		public function Model(name:String = null, data:Object = null, _dispatcher:IEventDispatcher = null) {
			if (name != "" && name != null) _name = name;
			_data = data;
			_dispatcher = dispatcher;
		}

		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		protected function initialize():void {
			
		}
		
		protected function dispose():void {
			
		}
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		somans function registerDispatcher(dispatcher:IEventDispatcher):void {
			_dispatcher = dispatcher;
			initialize();
		}
		
		somans function dispose():void {
			dispose();
		}
		
		public final function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void {
			dispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}

		public final function dispatchEvent(event:Event):Boolean {
			return dispatcher.dispatchEvent(event);
		}
		
		public final function hasEventListener(type:String):Boolean {
			return dispatcher.hasEventListener(type);
		}
		
		public final function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void {
			dispatcher.removeEventListener(type, listener, useCapture);
		}

		public final function willTrigger(type:String):Boolean {
			return dispatcher.willTrigger(type);
		}
		
		public final function get name():String {
			return _name;
		}
		
		public final function set name(value:String):void {
			_name = value;
		}
		
		public final function get data():Object {
			return _data;
		}
		
		public final function set data(value:Object):void {
			_data = value;
		}
		
		public final function get dispatcher():IEventDispatcher {
			return _dispatcher;
		}
		
	}
}