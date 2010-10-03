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

package com.soma.core.controller {
	import com.soma.core.interfaces.ISequenceCommand;

	import flash.events.Event;

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
	
	public class SequenceCommand extends Command implements ISequenceCommand {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		private var _commands:Array;
		private var _currentCommand:Event;
		
		//------------------------------------
		// public properties
		//------------------------------------
		
		
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		public function SequenceCommand() {
			
		}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		override protected final function initialize():void {
			_commands = [];
			initializeSubCommands();
		}
		
		protected function initializeSubCommands():void {
			
		}

		protected final function addSubCommand(event:Event):void {
			_commands.push(event);
			instance.controller.registerSequencedCommand(this, event);
		}
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		public final function execute(event:Event):void {
			if (_commands == null) return;
			_currentCommand = _commands.shift();
			if (hasCommand(_currentCommand.type)) instance.dispatchEvent(_currentCommand);
		}
		
		public final function executeNextCommand():void {
			if (_commands == null) return;
			instance.controller.unregisterSequencedCommand(this, _currentCommand);
			if (_commands.length > 0) {
				execute(_commands[0]);
			}
			else {
				_commands = null;
				_currentCommand = null;
			}
		}
		
		public final function get length():int {
			if (_commands == null) return -1;
			return _commands.length;
		}
		
		public final function stop():void {
			_commands = null;
			_currentCommand = null;
			instance.controller.unregisterSequencer(this);
		}
		
		public final function get currentCommand():Event {
			return _currentCommand;
		}
		
		public final function get commands():Array {
			return _commands;
		}
	}
}