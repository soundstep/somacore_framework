package com.soma.core.demo.helloworld.wires {
	import com.soma.core.demo.helloworld.SomaApplication;
	import com.soma.core.interfaces.IWire;
	import com.soma.core.wire.Wire;

	/**
	 * @author romuald
	 */
	public class MessageWire extends Wire implements IWire {
		
		public static const NAME:String = "APP::MessageWire";		public static const NAME_VIEW:String = "APP::MessageView";
		
		public function MessageWire() {
			super(NAME);
			trace(instance)
		}
		
		override protected function initialize():void {
			trace("------> initialize:", SomaApplication(instance).container)
		}

	}
}
