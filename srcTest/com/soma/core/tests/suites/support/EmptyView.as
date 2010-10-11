package com.soma.core.tests.suites.support {
	import flash.events.Event;
	import flash.display.Sprite;
	
	/**
	 * <b>Author:</b> Romuald Quantin - <a href="http://www.soundstep.com/" target="_blank">www.soundstep.com</a><br />
	 * <b>Class version:</b> 1.0<br />
	 * <b>Actionscript version:</b> 3.0<br />
	 * <b>Date:</b> Oct 9, 2010<br />
	 * @example
	 * <listing version="3.0"></listing>
	 */
	
	public class EmptyView extends Sprite {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		

		//------------------------------------
		// public properties
		//------------------------------------
		
		public static var NAME:String = "EmptyView";
		
		public static const EVENT_INITIALIZED:String = "EmptyView::Event.EVENT_INITIALIZED";
		public static const EVENT_DISPOSED:String = "EmptyView::Event.EVENT_DISPOSED";
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		public function EmptyView() {
			
		}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		
		//
		// PUBLIC
		//________________________________________________________________________________________________
		
		public function initializeView():void {
			dispatchEvent(new Event(EVENT_INITIALIZED));
		}
		
		public function dispose():void {
			dispatchEvent(new Event(EVENT_DISPOSED));
		}
		
	}
}