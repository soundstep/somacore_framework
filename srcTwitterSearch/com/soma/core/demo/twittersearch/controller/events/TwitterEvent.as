package com.soma.core.demo.twittersearch.controller.events {

	import flash.events.Event;	
	
	/**
	 * <b>Author:</b> Romuald Quantin - <a href="http://www.soundstep.com/" target="_blank">www.soundstep.com</a><br />
	 * <b>Class version:</b> 1.0<br />
	 * <b>Actionscript version:</b> 3.0<br />
	 * <b>Date:</b> Oct 25, 2010<br />
	 * @example
	 * <listing version="3.0"></listing>
	 */
	
	public class TwitterEvent extends Event {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		//------------------------------------
		// public properties
		//------------------------------------
		
		public static const SEARCH:String = "SEARCH";
		public static const SEARCH_RESULT:String = "SEARCH_RESULT";
		
		public var keywords:String;

		//------------------------------------
		// constructor
		//------------------------------------
		
		public function TwitterEvent(type:String, keywords:String = null, bubbles:Boolean = true, cancelable:Boolean = false) {
			this.keywords = keywords;
			super(type, bubbles, cancelable);
		}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		//
		// PUBLIC
		//________________________________________________________________________________________________
		
		override public function clone():Event {
			return new TwitterEvent(type, keywords, bubbles, cancelable);
		}
		
		override public function toString():String {
			return formatToString("TwitterEvent", "keywords", "type", "bubbles", "cancelable", "eventPhase");
		}
		
	}
}
