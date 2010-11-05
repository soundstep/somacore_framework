package com.soma.core.demo.di.views {

	import flash.display.Sprite;

	/**
	 * @author Romuald Quantin
	 */
	public class Car2 extends Sprite {
		
		private var _engine:IEngine;
		
		public function Car2(engine:IEngine) {
			_engine = engine;
			trace(this, ", engine is:", engine);
		}
		
	}
}
