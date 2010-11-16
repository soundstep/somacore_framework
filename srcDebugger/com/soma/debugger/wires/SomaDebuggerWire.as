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
 
 package com.soma.debugger.wires {
	import com.soma.core.interfaces.IWire;
	import com.soma.core.wire.Wire;
	import com.soma.debugger.commands.SomaDebuggerCommand;
	import com.soma.debugger.events.SomaDebuggerEvent;
	import com.soma.debugger.views.SomaDebuggerView;
	import com.soma.debugger.vo.SomaDebuggerVO;

	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.utils.Dictionary;

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
	
	public class SomaDebuggerWire extends Wire implements IWire {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		private var _debuggerName:String;
		private var _keyArray:Array;

		//------------------------------------
		// public properties
		//------------------------------------
		
		private var _pluginVO:SomaDebuggerVO;
		private var _enableLog:Boolean;
		private var _enableTrace:Boolean;
		private var _view:SomaDebuggerView;
		private var _commandsToLog:Dictionary;
		
		public static var NAME:String;
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		public function SomaDebuggerWire(debuggerName:String, pluginVO:SomaDebuggerVO) {
			super(debuggerName);
			NAME = debuggerName;
			_debuggerName = debuggerName;
			_pluginVO = pluginVO;
			_enableLog = pluginVO.enableLog;
			_enableTrace = pluginVO.enableTrace;
		}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		override public function initialize():void {
			if (stage == null) {
				trace("Error in ", this, " The stage is null.");
				return;
			}
			_commandsToLog = new Dictionary();
			_keyArray = [];
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyboardHandler);
			// commands to watch
			for (var i:int=0; i<_pluginVO.commands.length; i++) {
				addCommandToLog(_pluginVO.commands[i]);
			}
			// commands
			if (!hasCommand(SomaDebuggerEvent.SHOW_DEBUGGER)) addCommand(SomaDebuggerEvent.SHOW_DEBUGGER, SomaDebuggerCommand);
			if (!hasCommand(SomaDebuggerEvent.HIDE_DEBUGGER)) addCommand(SomaDebuggerEvent.HIDE_DEBUGGER, SomaDebuggerCommand);
			if (!hasCommand(SomaDebuggerEvent.MOVE_TO_TOP)) addCommand(SomaDebuggerEvent.MOVE_TO_TOP, SomaDebuggerCommand);
			if (!hasCommand(SomaDebuggerEvent.PRINT)) addCommand(SomaDebuggerEvent.PRINT, SomaDebuggerCommand);
			if (!hasCommand(SomaDebuggerEvent.CLEAR)) addCommand(SomaDebuggerEvent.CLEAR, SomaDebuggerCommand);
			// view
			_view = new SomaDebuggerView(_debuggerName);
			addView(_debuggerName + "View", _view);
			enableLog = _enableLog;
			enableTrace = _enableTrace;
			stage.addChild(debugger);
			// wires
			addWire(_debuggerName+"GCWire", new SomaDebuggerGCWire(_debuggerName));
		}
		
		private function eventsHandler(event:Event):void {
			debugger.printCommand(event.type, event);
		}

		private function keyboardHandler(event:KeyboardEvent):void {
			_keyArray.push(event.keyCode);
			if (_keyArray.length > 5) _keyArray.shift();
			if (_keyArray.join(",") == "68,69,66,85,71") show();
		}
		
		override public function dispose():void {
			// dispose objects, graphics and events listeners
			try {
				if (hasCommand(SomaDebuggerEvent.SHOW_DEBUGGER)) removeCommand(SomaDebuggerEvent.SHOW_DEBUGGER);
				if (hasCommand(SomaDebuggerEvent.HIDE_DEBUGGER)) removeCommand(SomaDebuggerEvent.HIDE_DEBUGGER);
				if (hasCommand(SomaDebuggerEvent.MOVE_TO_TOP)) removeCommand(SomaDebuggerEvent.MOVE_TO_TOP);
				if (hasCommand(SomaDebuggerEvent.PRINT)) removeCommand(SomaDebuggerEvent.PRINT);
				if (hasCommand(SomaDebuggerEvent.CLEAR)) removeCommand(SomaDebuggerEvent.CLEAR);
				removeAllCommandsToLog();
				removeView(_debuggerName + "View");
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyboardHandler);
				stage.removeChild(debugger);
				_commandsToLog = null;
				_keyArray = null;
				_view = null;
			} catch(e:Error) {
				trace("Error in", this, "(dispose method):", e.message);
			}
		}
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		public function get debugger():SomaDebuggerView {
			return _view as SomaDebuggerView;
		}
		
		public function get debuggerName():String {
			return _debuggerName;
		}
		
		public function print(value:Object, info:String):void {
			debugger.print(value, info);
		}

		public function moveToTop():void {
			var parent:DisplayObjectContainer = debugger.parent;
			if (parent != null) parent.setChildIndex(debugger, parent.numChildren- 1);
		}
		
		public function clear():void {
			debugger.clear();
		}
		
		public function addCommandToLog(commandName:String):void {
			_commandsToLog[commandName] = commandName;
			addEventListener(commandName, eventsHandler);
		}

		public function removeCommandToLog(commandName:String):void {
			delete _commandsToLog[commandName];
			removeEventListener(commandName, eventsHandler);
		}
		
		public function removeAllCommandsToLog():void {
			for each (var commandToLog:String in _commandsToLog) {
				delete _commandsToLog[commandToLog];
				removeEventListener(commandToLog, eventsHandler);
			}
		}

		public function get enableLog():Boolean {
			return _enableLog;
		}
		
		public function set enableLog(value:Boolean):void {
			_enableLog = value;
			debugger.enableLog = _enableLog;
		}

		public function get enableTrace():Boolean {
			return _enableTrace;
		}
		
		public function set enableTrace(value:Boolean):void {
			_enableTrace = value;
			debugger.enableTrace = _enableTrace;
		}
		
		public function show():void {
			debugger.visible = true;
		}
		
		public function hide():void {
			debugger.visible = false;
		}
		
	}
}