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
	 * <p><b>Author:</b> Romuald Quantin - <a href="http://www.soundstep.com/" target="_blank">www.soundstep.com</a></p>
	 * <p><b>Resources:</b> <a href="http://www.soundstep.com/downloads/somacore" target="_blank">http://www.soundstep.com/downloads/somacore</a></p>
	 * <p><b>Class version:</b> v2.0.0</p>
	 * <p><b>Actionscript version:</b> 3.0</p>
	 * <p><b>Copyright:</b>
	 * Mozilla Public License 1.1 (MPL 1.1)<br /> 
	 * <a href="http://www.opensource.org/licenses/mozilla1.1.php" target="_blank">http://www.opensource.org/licenses/mozilla1.1.php</a></p>
	 * The SequenceCommand class is used to execute a list of commands one after the other. The command added can be asynchronous or synchronous.
	 * @example
	 * Register commands and a sequence command.
	 * <listing version="3.0">
addCommand(MyEvent.DO_SOMETHING_ASYNCHRONOUS, CommandASyncExample);
addCommand(MyEvent.DO_SOMETHING_ELSE_ASYNCHRONOUS, CommandASyncExample);
addCommand(MyEvent.EXECUTE_SEQUENCE_COMMAND, SequenceCommandExample);
dispatchEvent(new MyEvent(MyEvent.EXECUTE_SEQUENCE_COMMAND));
	 * </listing>
	 * Each asynchronous command added to a sequence much use the executeNextCommand method. Here is an example.
	 * <listing version="3.0">
package {

	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	import flash.events.Event;
	import com.soma.core.interfaces.ICommandASync;
	import com.soma.core.controller.Command;
	
	public class CommandASyncExample extends Command implements ICommandASync {
		private var _event:Event;
		private var _timer:int;

		public function CommandASyncExample() {
			
		}
		
		public function execute(event:Event):void {
			_event = event;
			_timer = setTimeout(result, 1000, {});
		}
		
		public function fault(info:Object):void {
			
		}
		
		public function result(data:Object):void {
			if (isPartOfASequence(_event)) {
				getSequencer(_event).executeNextCommand();
			}
			_event = null;
			clearTimeout(_timer);
		}
		
	}
}
	 * </listing>
	 * Create a sequence command.
	 * <listing version="3.0">
package  {
	import com.soma.core.interfaces.ISequenceCommand;
	import com.soma.core.controller.SequenceCommand;
	
	public class SequenceCommandExample extends SequenceCommand implements ISequenceCommand {

		public function SequenceCommandExample() {
			
		}
		
		override protected function initializeSubCommands():void {
			addSubCommand(new MyEvent(MyEvent.DO_SOMETHING_ASYNCHRONOUS));
			addSubCommand(new MyEvent(MyEvent.DO_SOMETHING_ELSE_ASYNCHRONOUS));
		}
		
	}
}
	 * </listing>
	 * @see com.soma.core.controller.SomaController
	 * @see com.soma.core.controller.Command
	 * @see com.soma.core.controller.SequenceCommand
	 * @see com.soma.core.interfaces.IParallelCommand
	 * @see com.soma.core.interfaces.ICommandASync
	 */
	
	public class SequenceCommand extends Command implements ISequenceCommand {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		/** @private */
		private var _commands:Array;
		/** @private */
		private var _currentCommand:Event;
		
		//------------------------------------
		// public properties
		//------------------------------------
		
		
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		/**
		 * Create an instance of the SequenceCommand class. Should not be directly instantiated, the framework will instantiate the class.
		 */
		public function SequenceCommand() {
			
		}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		/** @private */
		override protected final function initialize():void {
			_commands = [];
			initializeSubCommands();
		}
		
		/** 
		 * Method that you can overwrite to add commands to the sequence command.
		 * @see com.soma.core.controller.SomaController
		 * @example
		 * <listing version="3.0">addSubCommand(new MyEvent(MyEvent.DO_SOMETHING_ASYNC));</listing>
		 */
		protected function initializeSubCommands():void {
			
		}
		
		/**
		 * Add a command to the list of commands to execute one after the other.
		 * @param event Event instance (must be registered as a command previously).
		 * @see com.soma.core.controller.SomaController
		 * @example
		 * <listing version="3.0">addSubCommand(new MyEvent(MyEvent.DO_SOMETHING_ASYNC));</listing>
		 */
		protected final function addSubCommand(event:Event):void {
			_commands.push(event);
			instance.controller.registerSequencedCommand(this, event);
		}
		
		//
		// PUBLIC
		//________________________________________________________________________________________________
		
		/** @private */
		public final function execute(event:Event):void {
			if (_commands == null) return;
			_currentCommand = _commands.shift();
			if (hasCommand(_currentCommand.type)) instance.dispatchEvent(_currentCommand);
		}
		
		/**
		 * Method used to execute the next command in the list of subcommands.
		 */
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
		
		/**
		 * Retrieves the number of commands added as subcommands.
		 * @return An integer.
		 */
		public final function get length():int {
			if (_commands == null) return -1;
			return _commands.length;
		}
		
		/**
		 * Stops the current sequence.
		 */
		public final function stop():void {
			_commands = null;
			_currentCommand = null;
			instance.controller.unregisterSequencer(this);
		}
		
		/**
		 * Retrieves the command that is currently executed (running).
		 * @return An event instance.
		 */
		public final function get currentCommand():Event {
			return _currentCommand;
		}
		
		/**
		 * Retrieves the list of commands added as subcommands.
		 * @return An Array of commands.
		 */
		public final function get commands():Array {
			return _commands;
		}
	}
}