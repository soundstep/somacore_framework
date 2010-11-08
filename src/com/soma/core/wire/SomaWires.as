/**
 * The contents of this file are subject to the Mozilla Public License
 * Version 1.1 (the "License"); you may not use this file except in compliance
 * with the License. You may obtain a copy of the License at
 * 
 * http://www.mozilla.org/MPL/
 * 
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied.
 * See the License for the specific language governing rights and
 * limitations under the License.
 * 
 * The Original Code is SomaCore.
 * 
 * The Initial Developer of the Original Code is Romuald Quantin.
 * romu@soundstep.com (www.soundstep.com).
 * 
 * Portions created by
 * 
 * Initial Developer are Copyright (C) 2008-2010 Soundstep. All Rights Reserved.
 * All Rights Reserved.
 * 
 */

package com.soma.core.wire {
	import com.soma.core.ns.somans;
	import com.soma.core.interfaces.ISoma;
	import com.soma.core.interfaces.IWire;

	import flash.utils.Dictionary;

	/**
	 * <p><b>Author:</b> Romuald Quantin - <a href="http://www.soundstep.com/" target="_blank">www.soundstep.com</a></p>
	 * <p><b>Resources:</b> <a href="http://www.soundstep.com/downloads/somacore" target="_blank">http://www.soundstep.com/downloads/somacore</a></p>
	 * <p><b>Class version:</b> v1.0.0</p>
	 * <p><b>Actionscript version:</b> 3.0</p>
	 * <p><b>Copyright:</b>
	 * Mozilla Public License 1.1 (MPL 1.1)<br /> 
	 * <a href="http://www.opensource.org/licenses/mozilla1.1.php" target="_blank">http://www.opensource.org/licenses/mozilla1.1.php</a></p>
	 * The SomaWires class handles the wires of the application. See the Wire class documentation for implementation. 
	 * @see com.soma.core.wire.Wire
	 */
	
	public class SomaWires {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		/** @private */
		private var _instance:ISoma;
		/**
		 * List of the wires registered to the framework.
		 */
		protected var wires:Dictionary;

		//------------------------------------
		// public properties
		//------------------------------------
		
		
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		/**
		 * Create an instance of the SomaWires class. Should not be directly instantiated, the framework will instantiate the class.
		 */
		public function SomaWires(instance:ISoma) {
			_instance = instance;
			initialize();
		}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		/** @private */
		private function initialize():void {
			wires = new Dictionary();
		}
				
		//
		// PUBLIC
		//________________________________________________________________________________________________
		
		/**
		 * Destroys all the models and properties. The class will call the dispose method of each model instance.
		 */
		public function dispose():void {
			for (var name:String in wires) {
				removeWire(name);
			}
			_instance = null;
			wires = null;
		}
		
		/**
		 * Indicates wether a wire has been registered to the framework.
		 * @param wireName Name of the wire.
		 * @return A Boolean.
		 * @see com.soma.core.wire.SomaWires
		 * @example
		 * <listing version="3.0">hasWire(MyWire.NAME);</listing>
		 */
		public function hasWire(wireName:String):Boolean {
			if (!wires) return false;
			return (wires[wireName] != null || wires[wireName] != undefined);
		}
		
		/**
		 * Registers a wire to the framework.
		 * @param wireName Name of the wire.
		 * @param view Instance of the wire.
		 * @return The wire instance.
		 * @see com.soma.core.wire.SomaWires
		 * @example
		 * <listing version="3.0">addWire(MyWire.NAME, new MyWire());</listing>
		 */
		public function addWire(wireName:String, wire:IWire):IWire {
			if (!wires) return null;
			if (hasWire(wireName)) {
				throw new Error("Error in " + this + " Wire \"" + wireName + "\" already registered.");
			}
			wires[wireName] = wire;
			wire.instance = _instance;
			return wire;
		}
		
		/**
		 * Removes a wire from the framework and call the dispose method of this wire.
		 * @param wireName Name of the wire.
		 * @see com.soma.core.wire.SomaWires
		 * @example
		 * <listing version="3.0">removeWire(MyWire.NAME);</listing>
		 */
		public function removeWire(wireName:String):void {
			if (!wires) return;
			if (!hasWire(wireName)) {
				throw new Error("Error in " + this + " Wire \"" + wireName + "\" not registered.");
			}
			Wire(wires[wireName]).somans::dispose();
			wires[wireName] = null;
			delete wires[wireName];
		}
		
		/**
		 * Retrieves the wire instance that has been registered using its name.
		 * @param wireName Name of the wire.
		 * @return A wire instance.
		 * @see com.soma.core.wire.SomaWires
		 * @example
		 * <listing version="3.0">var myWire:MyWire = getWire(MyWire.NAME) as MyWire;</listing>
		 */
		public function getWire(wireName:String):IWire {
			if (!wires) return null;
			if (!hasWire(wireName)) return null;
			return wires[wireName];
		}
		
		/**
		 * Retrieves all the wire instances that have been registered to the framework.
		 * @return A Dictionary (the key of the Dictionary is the name used for the registration).
		 * @see com.soma.core.wire.SomaWires
		 * @example
		 * <listing version="3.0">var wires:Dictionary = getWires();</listing>
		 */
		public function getWires():Dictionary {
			if (!wires) return null;
			var clone:Dictionary = new Dictionary();
			for (var name:String in wires) clone[name] = wires[name];
			return clone;
		}
		
	}
}