package com.soma.core.demo.di.views {
	/**
	 * @author Romuald Quantin
	 */
	public class TestNamedInjection {
		
		[Inject]
		[Named(index="1", name="url")]
		public var url:String;
		
		[PostConstruct]
		public function print():void {
			trace(this, url);
		}
		
	}
}
