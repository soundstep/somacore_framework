package com.soma.core.wire {
	import com.soma.core.interfaces.ISoma;
	import com.soma.core.interfaces.IWire;

	import flash.utils.Dictionary;

	/**
	 * <b>Author:</b> Romuald Quantin - <a href="http://www.soundstep.com/" target="_blank">www.soundstep.com</a><br />* <b>Class version:</b> 1.0<br />
	 * <b>Actionscript version:</b> 3.0<br />
	 * <b>Copyright:</b> 
	 * <br />
	 * <b>Date:</b> Sep 17, 2009<br />
	 * <b>Usage:</b>
	 * @example
	 * <listing version="3.0"></listing>
	 */
	
	public class SomaWires {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		namespace somans = "http://www.soundstep.com/soma";
		
		private var _instance:ISoma;
		protected var wires:Dictionary;

		//------------------------------------
		// public properties
		//------------------------------------
		
		
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		public function SomaWires(instance:ISoma) {
			_instance = instance;
			initialize();
		}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		private function initialize():void {
			wires = new Dictionary();
		}
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		public function dispose() : void {
			for (var name:String in wires) {
				removeWire(name);
			}
			_instance = null;
			wires = null;
		}
		
		public function hasWire(wireName:String):Boolean {
			if (!wires) return false;
			return (wires[wireName] != null || wires[wireName] != undefined);
		}
		
		public function addWire(wireName:String, wire:IWire):IWire {
			if (!wires) return null;
			if (hasWire(wireName)) {
				throw new Error("Error in " + this + " Wire \"" + wireName + "\" already registered.");
			}
			wires[wireName] = wire;
			Wire(wire).somans::registerInstance(_instance);
			return wire;
		}
		
		public function removeWire(wireName:String):void {
			if (!wires) return;
			if (!hasWire(wireName)) {
				throw new Error("Error in " + this + " Wire \"" + wireName + "\" not registered.");
			}
			Wire(wires[wireName]).somans::dispose();
			wires[wireName] = null;
			delete wires[wireName];
		}
		
		public function getWire(wireName:String):IWire {
			if (!wires) return null;
			if (!hasWire(wireName)) return null;
			return wires[wireName];
		}
		
		public function getWires():Dictionary {
			if (!wires) return null;
			var clone:Dictionary = new Dictionary();
			for (var name:String in wires) clone[name] = wires[name];
			return clone;
		}
		
	}
}