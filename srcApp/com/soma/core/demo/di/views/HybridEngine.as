package com.soma.core.demo.di.views {


	import flash.display.Sprite;
	/**
	 * @author Romuald Quantin
	 */
	public class HybridEngine extends Sprite  implements IEngine {
		
		public function HybridEngine() {
			
		}
		
		public function start():void {
			trace(this, "has started!");
		}
		
	}
}
