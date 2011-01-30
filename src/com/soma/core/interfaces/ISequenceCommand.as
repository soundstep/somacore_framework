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

package com.soma.core.interfaces {
	import flash.events.Event;

	/**
	 * <p><b>Author:</b> Romuald Quantin - <a href="http://www.soundstep.com/" target="_blank">www.soundstep.com</a></p>
	 * <p><b>Resources:</b> <a href="http://www.soundstep.com/downloads/somacore" target="_blank">http://www.soundstep.com/downloads/somacore</a></p>
	 * <p><b>Class version:</b> v2.0.0</p>
	 * <p><b>Actionscript version:</b> 3.0</p>
	 * <p><b>Copyright:</b>
	 * Mozilla Public License 1.1 (MPL 1.1)<br /> 
	 * <a href="http://www.opensource.org/licenses/mozilla1.1.php" target="_blank">http://www.opensource.org/licenses/mozilla1.1.php</a></p>
	 * @see com.soma.core.controller.SequenceCommand
	 */
	
	public interface ISequenceCommand extends ICommand {
		
		/**
		 * Method used to execute the next command in the list of subcommands.
		 */
		function executeNextCommand():void;
		/**
		 * Retrieves the number of commands added as subcommands.
		 * @return An integer.
		 */
		function get length():int;
		/**
		 * Retrieves the command that is currently executed (running).
		 * @return An event instance.
		 */
		function get currentCommand():Event;
		/**
		 * Stops the current sequence.
		 */
		function stop():void;
		/**
		 * Retrieves the list of commands added as subcommands.
		 * @return An Array of commands.
		 */
		function get commands():Array;
		
	}
}