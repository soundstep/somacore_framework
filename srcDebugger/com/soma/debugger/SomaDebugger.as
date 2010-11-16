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
 
 package com.soma.debugger {
	import com.soma.debugger.wires.SomaDebuggerGCWire;
	import com.soma.core.interfaces.ISoma;
	import com.soma.core.interfaces.ISomaPlugin;
	import com.soma.core.interfaces.ISomaPluginVO;
	import com.soma.debugger.views.SomaDebuggerView;
	import com.soma.debugger.vo.SomaDebuggerVO;
	import com.soma.debugger.wires.SomaDebuggerWire;

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
	
	public class SomaDebugger implements ISomaPlugin {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		private var _instance:ISoma;
		private var _wire:SomaDebuggerWire;		private var _wireGC:SomaDebuggerGCWire;
		private var _view:SomaDebuggerView;
		private var _name:String;

		//------------------------------------
		// public properties
		//------------------------------------
		
		public static const NAME_DEFAULT:String = "Soma::SomaDebugger";
		
		public static var DEFAULT_WINDOW_WIDTH:Number = 450;
		public static var DEFAULT_WINDOW_HEIGHT:Number = 180;
		public static var DEFAULT_WINDOW_INSPECTOR_WIDTH:Number = 450;
		public static var DEFAULT_WINDOW_INSPECTOR_HEIGHT:Number = 250;
		public static var DEFAULT_WINDOW_GC_REPORT_WIDTH:Number = 450;
		public static var DEFAULT_WINDOW_GC_REPORT_HEIGHT:Number = 250;
		public static var DEFAULT_DISPLAY_COMMANDS_PROPERTIES:Boolean = true;
		public static var DEFAULT_LOG_MAX_STRING_LENGTH:int = 170;
		
		public static var WEAK_REFERENCE:Boolean = true;
		
		public static var DEFAULT_GC_CHECK_TICK:Number = 1000;
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		public function SomaDebugger() {
			
		}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		public function initialize(pluginVO:ISomaPluginVO):void {
			if (!(pluginVO is SomaDebuggerVO) || pluginVO == null) throw new Error("Error in " + this + " The pluginVO is null or is not an instance of SomaDebuggerPluginVO");
			try {
				var vo:SomaDebuggerVO = pluginVO as SomaDebuggerVO;
				if (vo == null || vo.instance == null || vo.instance.wires == null) throw new Error("Soma is not initialized properly.");
				_name = (vo.debuggerName == null || vo.debuggerName == "") ? NAME_DEFAULT : vo.debuggerName;
				_instance = vo.instance;
				_wire = _instance.wires.addWire(_name, new SomaDebuggerWire(_name, vo)) as SomaDebuggerWire;				_wireGC = _instance.wires.getWire(_name+"GCWire") as SomaDebuggerGCWire;
				_view = _wire.debugger;
			} catch (e:Error) {
				trace("Error in " + this + " " + e);
			}
		}
		
		public function printCommand(type:String = "message", event:Event = null):void {
			if (_view != null) _view.printCommand(type, event);
		}
		
		public function print(value:Object, info:String = null):void {
			if (_view != null) _view.print(value, info);
		}
		
		public function clear():void {
			if (_view != null) _view.clear();
		}

		public function addCommandToLog(commandName:String):void {
			if (_wire != null) _wire.addCommandToLog(commandName);
		}

		public function removeCommandToLog(commandName:String):void {
			if (_wire != null) _wire.removeCommandToLog(commandName);
		}
		
		public function removeAllCommandsToLog():void {
			if (_wire != null) _wire.removeAllCommandsToLog();
		}
		
		public function addGCWatcher(name:String, object:Object):void {
			if (_wireGC != null) _wireGC.addWatcher(name, object);
		}
		
		public function removeGCWatcher(name:String):void {
			if (_wireGC != null) _wireGC.removeWatcher(name);
		}
		
		public function removeAllGCWatchers():void {
			if (_wireGC != null) _wireGC.removeAllWatchers();
		}
		
		public function get wire():SomaDebuggerWire {
			return _wire;
		}
		
		public function get view():SomaDebuggerView {
			return _view;
		}
		
		public function get name():String {
			return _name;
		}
		
		public function dispose():void {
			// dispose objects, graphics and events listeners
			try {
				_instance.removeWire(_name);
				_instance.removeWire(_name+"GCWire");
				_instance = null;
				_wire = null;
				_wireGC = null;
				_view = null;
			} catch(e:Error) {
				trace("Error in", this, "(dispose method):", e.message);
			}
		}

	}
}