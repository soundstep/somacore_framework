package com.soma.core.demo.di.views {

	import flash.display.Sprite;

	/**
	 * @author Romuald Quantin
	 */
	public class SportyEngine extends Sprite implements IEngine {
		
		public function SportyEngine() {
			
		}
		
		public function start():void {
			trace(this, "has started!");
		}
		
	}
}
