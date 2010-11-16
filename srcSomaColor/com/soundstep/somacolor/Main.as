package com.soundstep.somacolor {
	import flash.display.Sprite;

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
	
	public class Main extends Sprite {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		private var _app:SomaApplication;
		
		//------------------------------------
		// public properties
		//------------------------------------
		
		
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		public function Main() {
			initialize();
		}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		private function initialize():void {
			_app = new SomaApplication(stage, true);
		}
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		
		
	}
}