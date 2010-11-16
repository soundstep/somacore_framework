package com.soundstep.somacolor.views {
	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * <b>Author:</b> Romuald Quantin - <a href="http://www.soundstep.com/" target="_blank">www.soundstep.com</a><br />* <b>Class version:</b> 1.0<br />
	 * <b>Actionscript version:</b> 3.0<br />
	 * <b>Copyright:</b> 
	 * <br />
	 * <b>Date:</b> Sep 22, 2009<br />
	 * <b>Usage:</b>
	 * @example
	 * <listing version="3.0"></listing>
	 */
	
	public class ColorSquare extends Sprite {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		
		
		//------------------------------------
		// public properties
		//------------------------------------
		
		

		//------------------------------------
		// constructor
		//------------------------------------
		
		public function ColorSquare() {
			addEventListener(Event.ADDED_TO_STAGE, added, false, 0, true);
		}

		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		private function added(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, added, false);
			init();
		}
		
		private function init():void {
			graphics.beginFill(Math.random() * 0xFFFFFF);
			graphics.drawRect(0, 0, 100, 100);
			graphics.endFill();
		}
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		public function dispose():void {
			
		}
		
	}
}
