package com.cafetownsend.events {
	import flash.events.Event;

	public class NavigationEvent extends Event {

		public static const SELECT:String = "NavigationEvent.SELECT";
		
		public var navigationID:int;
		
		public function NavigationEvent(type:String, navigationID:int, bubbles:Boolean = true, cancelable:Boolean = false) {
			this.navigationID = navigationID;
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event {
			return new NavigationEvent(type, navigationID, bubbles, cancelable);
		}
		
		override public function toString():String {
			return formatToString("NavigationEvent", "navigationID", "type", "bubbles", "cancelable", "eventPhase");
		}
		
	}
}
