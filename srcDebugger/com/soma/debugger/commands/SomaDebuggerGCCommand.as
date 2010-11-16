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
 * The Original Code is SomaDebugger.
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
 
 package com.soma.debugger.commands {
	import com.soma.core.controller.Command;
	import com.soma.core.interfaces.ICommand;
	import com.soma.debugger.events.SomaDebuggerGCEvent;
	import com.soma.debugger.wires.SomaDebuggerGCWire;

	import flash.events.Event;

	/**
	 * <b>Author:</b> Romuald Quantin - <a href="http://www.soundstep.com/" target="_blank">www.soundstep.com</a><br />
	 * <b>Class version:</b> v1.0.1<br />
	 * <b>Actionscript version:</b> 3.0<br />
	 * <b>Copyright:</b>
	 * Mozilla Public License 1.1 (MPL 1.1)<br /> 
	 * <a href="http://www.opensource.org/licenses/mozilla1.1.php" target="_blank">http://www.opensource.org/licenses/mozilla1.1.php</a><br />
	 * <br />
	 * <b>Usage:</b><br />
	 * @example
	 * <listing version="3.0">
	 * </listing>
	 */
	
	public class SomaDebuggerGCCommand extends Command implements ICommand {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		

		//------------------------------------
		// public properties
		//------------------------------------
		
		
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		public function SomaDebuggerGCCommand() {
			
		}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		public function execute(event:Event):void {
			try {
				var debuggerGCEvent:SomaDebuggerGCEvent = event as SomaDebuggerGCEvent;
				var debuggerName:String = (debuggerGCEvent.debuggerName == null || debuggerGCEvent.debuggerName == "") ? "Soma::SomaDebugger" : debuggerGCEvent.debuggerName;
				var wire:SomaDebuggerGCWire = getWire(debuggerName+"GCWire") as SomaDebuggerGCWire;
				if (wire != null) {
					switch (event.type) {
						case SomaDebuggerGCEvent.ADD_WATCHER:
							if (debuggerGCEvent.nameObjectToWatch == null ||
								debuggerGCEvent.nameObjectToWatch == "" ||
								debuggerGCEvent.objectToWatch == null) {
								return;
							}
							wire.addWatcher(debuggerGCEvent.nameObjectToWatch, debuggerGCEvent.objectToWatch);
							break;
						case SomaDebuggerGCEvent.REMOVE_WATCHER:
							if (debuggerGCEvent.nameObjectToWatch == null ||
								debuggerGCEvent.nameObjectToWatch == "") {
								return;
							}
							wire.removeWatcher(debuggerGCEvent.nameObjectToWatch);
							break;
						case SomaDebuggerGCEvent.REMOVE_ALL_WATCHERS:
							wire.removeAllWatchers();
							break;
						case SomaDebuggerGCEvent.FORCE_GC:
							wire.forceGC();
							break;
					}
				}
			} catch (err:Error) {
				trace("Error in ", this, " ", err.message);
			}
		}
		
	}
}