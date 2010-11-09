package com.soma.core.demo.di.wires {
	import com.soma.core.demo.di.models.SimpleModel;
	import com.soma.core.demo.di.views.SimpleView;
	import com.soma.core.wire.Wire;
	/**
	 * @author Romuald Quantin
	 */
	public class GreetingWire extends Wire {
		
		[Inject]
		public var wire:GreetingWire2;
		
		[Inject]
		public var simpleView:SimpleView;
		
		[Inject]
		public var model:SimpleModel;
		
		public static var count:int = 0;
		
		public function GreetingWire() {
			trace(count++, this, wire);
		}
		
		override public function initialize():void {
			trace(this, "initialize", "has a wire: ", wire);
		}
		
	}
}
