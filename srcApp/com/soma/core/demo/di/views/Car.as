package com.soma.core.demo.di.views {

	import flash.display.Sprite;

	/**
	 * @author Romuald Quantin
	 */
	public class Car extends Sprite {
		
		[Inject]
		public var engine:LittleEngine;
		
		public function Car() {
			
		}
		
		[PostConstruct]
		public function initialize():void {
			trace(this, ", engine is:", engine);
		}
		
	}
}
