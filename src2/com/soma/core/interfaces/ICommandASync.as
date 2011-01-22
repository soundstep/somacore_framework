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

	/**
	 * <p><b>Author:</b> Romuald Quantin - <a href="http://www.soundstep.com/" target="_blank">www.soundstep.com</a></p>
	 * <p><b>Resources:</b> <a href="http://www.soundstep.com/downloads/somacore" target="_blank">http://www.soundstep.com/downloads/somacore</a></p>
	 * <p><b>Class version:</b> v1.0.0</p>
	 * <p><b>Actionscript version:</b> 3.0</p>
	 * <p><b>Copyright:</b>
	 * Mozilla Public License 1.1 (MPL 1.1)<br /> 
	 * <a href="http://www.opensource.org/licenses/mozilla1.1.php" target="_blank">http://www.opensource.org/licenses/mozilla1.1.php</a></p>
	 * Interface used to create asynchronous command.
	 * @example
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
	 * @see com.soma.core.controller.Command	 * @see com.soma.core.interfaces.ICommand	 * @see com.soma.core.interfaces.IResponder
	 */
	
	public interface ICommandASync extends ICommand, IResponder {
		
	}
}
