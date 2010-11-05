package com.soma.core.demo.di.views {
	/**
	 * @author Romuald Quantin
	 */
	public class TestInjection {
		
		[Inject]
		public var url:String;
		
		[PostConstruct]
		public function print():void {
			trace(this, url);
		}
		
	}
}
