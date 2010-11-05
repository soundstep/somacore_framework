package com.soma.core.demo.di.views {
	import flash.display.Sprite;
	/**
	 * @author Romuald Quantin
	 */
	public class SimpleView extends Sprite {
		
		public static var count:int = 0;
		
		public function SimpleView() {
			trace(count++, this);
		}
		
	}
}
