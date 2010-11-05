package com.soma.core.demo.di.wires {
	import com.soma.core.demo.di.models.SimpleModel;
	import com.soma.core.interfaces.IWire;
	import com.soma.core.wire.Wire;

	/**
	 * @author romualdq
	 */
	public class WireTest1 extends Wire implements IWire {
		
		[Inject]
		public var model:SimpleModel;
		
		public static var count:int = 0;
		
		public function WireTest1() {
			trace(count++, "COUNT", this);
		}
		
	}
}
