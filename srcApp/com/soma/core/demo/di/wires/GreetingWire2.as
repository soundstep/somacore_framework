package com.soma.core.demo.di.wires {
	import com.soma.core.demo.di.models.SimpleModel;
	import com.soma.core.wire.Wire;
	/**
	 * @author Romuald Quantin
	 */
	public class GreetingWire2 extends Wire {
		
		[Inject]
		public var model:SimpleModel;
		
		public static const NAME:String = "APP::GreetingWire2";
		
		public static var count:int = 0;
		
		public function GreetingWire2() {
			trace(count++, this);
		}
		
		override protected function initialize():void {
			trace(this, "initialize", _name);
		}
		
	}
}
