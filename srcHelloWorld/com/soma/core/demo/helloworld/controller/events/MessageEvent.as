package com.soma.core.demo.helloworld.controller.events {
	import flash.events.Event;

	/**
	 * @author romuald
	 */
	public class MessageEvent extends Event {
		
		public static const READY:String = "READY";
		public static const REQUEST:String = "REQUEST";
		
		public var message:String;
		
		public function MessageEvent(type:String, bubbles:Boolean = true, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event {
			var event:MessageEvent = new MessageEvent(type, bubbles, cancelable);
			event.message = message;
			return event;
		}
		
	}
}
