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
	 * <b>Author:</b> Romuald Quantin - <a href="http://www.soundstep.com/" target="_blank">www.soundstep.com</a><br />
	 * <b>Class version:</b> v1.0.0<br />
	 * <b>Actionscript version:</b> 3.0<br />
	 * <b>Copyright:</b>
	 * Mozilla Public License 1.1 (MPL 1.1)<br /> 
	 * <a href="http://www.opensource.org/licenses/mozilla1.1.php" target="_blank">http://www.opensource.org/licenses/mozilla1.1.php</a><br />
	 * You can use SomaCore in anything, except to include/distribute it in another framework, application, template, component or structure that is meant to build, scaffold or generate source files.<br />
	 * <br />
	 * <b>Usage:</b><br />
	 * @example
	 * <listing version="3.0">
	 * </listing>
	 */
	
	public class SomaWires {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
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
				
		//
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