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
	import com.soma.core.interfaces.IParallelCommand;

	import flash.events.Event;

	/**
	 * <p><b>Author:</b> Romuald Quantin - <a href="http://www.soundstep.com/" target="_blank">www.soundstep.com</a></p>
	 * <p><b>Resources:</b> <a href="http://www.soundstep.com/downloads/somacore" target="_blank">http://www.soundstep.com/downloads/somacore</a></p>
	 * <p><b>Class version:</b> v1.0.0</p>
	 * <p><b>Actionscript version:</b> 3.0</p>
	 * <p><b>Copyright:</b>
	 * Mozilla Public License 1.1 (MPL 1.1)<br /> 
	 * <a href="http://www.opensource.org/licenses/mozilla1.1.php" target="_blank">http://www.opensource.org/licenses/mozilla1.1.php</a></p>
	 * The ParallelCommand class is used to execute a list of commands at the same time.
	 * @example
	 * Register commands and a parallel command.
	 * <listing version="3.0">
addCommand(MyEvent.DO_SOMETHING, CommandExample);
addCommand(MyEvent.DO_SOMETHING_ELSE, CommandExample);
addCommand(MyEvent.EXECUTE_PARALLEL_COMMAND, ParallelCommandExample);
dispatchEvent(new MyEvent(MyEvent.EXECUTE_PARALLEL_COMMAND));
	 * </listing>
	 * <listing version="3.0">
package  {
	import com.soma.core.interfaces.IParallelCommand;
	import com.soma.core.controller.ParallelCommand;
	
	public class ParallelCommandExample extends ParallelCommand implements IParallelCommand {

		public function ParallelCommandExample() {
			
		}
		
		override protected function initializeSubCommands():void {
			addSubCommand(new MyEvent(MyEvent.DO_SOMETHING));
			addSubCommand(new MyEvent(MyEvent.DO_SOMETHING_ELSE));
		}
		
	}
}
	 * </listing>
	 * @see com.soma.core.controller.SomaController
	 * @see com.soma.core.controller.Command
	 * @see com.soma.core.controller.SequenceCommand
	 * @see com.soma.core.interfaces.IParallelCommand
	 */
	
	public class ParallelCommand extends Command implements IParallelCommand {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		/** @private */
		private var _commands:Array;

		//------------------------------------
		// public properties
		//------------------------------------
		
		
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		/**
		 * Create an instance of the ParallelCommand class. Should not be directly instantiated, the framework will instantiate the class.
		 */
		public function ParallelCommand() {
			
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
		 * Method that you can overwrite to add commands to the parallele command.
		 * @see com.soma.core.controller.SomaController
		 * @example
		 * <listing version="3.0">addSubCommand(new MyEvent(MyEvent.DO_SOMETHING));</listing>
		 */
		protected function initializeSubCommands():void {
			
		}
		
		/**
		 * Add a command to the list of commands to execute in parallel.
		 * @param event Event instance (must be registered as a command previously).
		 * @see com.soma.core.controller.SomaController
		 * @example
		 * <listing version="3.0">addSubCommand(new MyEvent(MyEvent.DO_SOMETHING));</listing>
		 */
		protected final function addSubCommand(event:Event):void {
			_commands.push(event);
		}
		
		//
		// PUBLIC
		//________________________________________________________________________________________________
		
		/** @private */
		public final function execute(event:Event):void {
			while (_commands.length > 0) {
				var command:Event = _commands.shift();
				if (hasCommand(command.type)) instance.dispatchEvent(command);
			}
			_commands = null;
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
		 * Retrieves the list of commands added as subcommands.
		 * @return An Array of commands.
		 */
		public final function get commands():Array {
			return _commands;
		}
	}
}