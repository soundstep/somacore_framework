package com.cafetownsend.events {
	import flash.events.Event;

	public class StartEvent extends Event {

		public static const START:String = "start";
		
		public function StartEvent(type:String, bubbles:Boolean = true, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event {
			return new StartEvent(type, bubbles, cancelable);
		}
		
		override public function toString():String {
			return formatToString("StartEvent", "type", "bubbles", "cancelable", "eventPhase");
		}
		
	}
}
