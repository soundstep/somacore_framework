package com.soma.core.demo.di.views {

	import flash.display.Sprite;

	/**
	 * @author Romuald Quantin
	 */
	public class LittleEngine extends Sprite implements IEngine {
		
		public function LittleEngine() {
			
		}
		
		public function start():void {
			trace(this, "has started!");
		}
		
	}
}
