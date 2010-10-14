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
	import com.soma.core.ns.somans;
	import com.soma.core.interfaces.ICommand;
	import com.soma.core.interfaces.ISequenceCommand;
	import com.soma.core.interfaces.ISoma;

	import flash.events.Event;
	import flash.utils.Dictionary;

	/**
	 * <p><b>Author:</b> Romuald Quantin - <a href="http://www.soundstep.com/" target="_blank">www.soundstep.com</a></p>
	 * <p><b>Resources:</b> <a href="http://www.soundstep.com/downloads/somacore" target="_blank">http://www.soundstep.com/downloads/somacore</a></p>
	 * <p><b>Class version:</b> v1.0.0</p>
	 * <p><b>Actionscript version:</b> 3.0</p>
	 * <p><b>Copyright:</b>
	 * Mozilla Public License 1.1 (MPL 1.1)<br /> 
	 * <a href="http://www.opensource.org/licenses/mozilla1.1.php" target="_blank">http://www.opensource.org/licenses/mozilla1.1.php</a></p>
	 * 
	 * @example
	 * <listing version="3.0">
	 * </listing>
	 */
	
	public class SomaController {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		private var _instance:ISoma;
		
		private var _commands:Dictionary;
		private var _sequencers:Dictionary;
		private var _lastEvent:Event;
		private var _lastSequencer:ISequenceCommand;

		//------------------------------------
		// public properties
		//------------------------------------
		
		
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		public function SomaController(instance:ISoma) {
			_instance = instance;
			initialize();
		}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		public function dispose():void {
			for (var nameCommand:String in _commands) {
				removeCommand(nameCommand);
			}
			for (var nameSequencer:String in _sequencers) {
				_sequencers[nameSequencer] = null;
				delete _sequencers[nameSequencer];
			}
			_instance = null;
			_commands = null;
			_sequencers = null;
			_lastEvent = null;
			_lastSequencer = null;
		}
		
		private function initialize():void {
			_commands = new Dictionary();
			_sequencers = new Dictionary();
		}
		
		private function addInterceptor(commandName:String):void {
			if (_instance.stage == null) return;
			// handle events dispatched from the stage
			_instance.stage.addEventListener(commandName, displayListHandler, false, int.MIN_VALUE);
			// handle events dispatched from the display list
			_instance.stage.addEventListener(commandName, displayListHandler, true, int.MIN_VALUE);
			// handle events dispatched from the facade
			_instance.addEventListener(commandName, instanceHandler, false, int.MIN_VALUE);
		}
		
		private function removeInterceptor(commandName:String):void {
			if (_instance.stage == null) return;
			_instance.stage.removeEventListener(commandName, displayListHandler, false);
			_instance.stage.removeEventListener(commandName, displayListHandler, true);
			_instance.removeEventListener(commandName, instanceHandler, false);
		}

		private function displayListHandler(event:Event):void {
			if (event.bubbles && hasCommand(event.type)) {
				event.stopPropagation();
				var clonedEvent:Event = event.clone();
				// store a reference of the events not to dispatch it twice
				// in case it is dispatched from the display list
				_lastEvent = clonedEvent;
				_instance.dispatchEvent(clonedEvent);
				if (!clonedEvent.isDefaultPrevented()) {
					executeCommand(event);				}
				_lastEvent = null;
			}
		}
		
		private function instanceHandler(event:Event):void {
			if (event.bubbles && hasCommand(event.type)) {
				// if the event is equal to the lastEvent, this has already been dispatched for execution
				if (_lastEvent != event) {
					if (!event.isDefaultPrevented()) {
						executeCommand(event);
					}
				}
			}
			_lastEvent = null;
		}

		internal function executeCommand(event:Event):void {
			if (hasCommand(event.type)) {
				var CommandClass:Class = _commands[event.type];
				var command:ICommand = new CommandClass();
				Command(command).somans::registerInstance(_instance);
				command.execute(event);
			}
		}
		
		internal function registerSequencedCommand(sequencer:ISequenceCommand, event:Event):void {
			if (event == null) return;
			if (_sequencers[sequencer] == null || _sequencers[sequencer] == undefined) {
				_lastSequencer = sequencer;
				_sequencers[sequencer] = [];
			}
			_sequencers[sequencer].push(event);
		}

		internal function unregisterSequencedCommand(sequencer:ISequenceCommand, event:Event):void {
			if (event == null) return;
			if (_lastSequencer == sequencer) _lastSequencer = null;
			if (_sequencers[sequencer] != null && _sequencers[sequencer] != undefined) {
				var i:Number = 0;
				var l:int = _sequencers[sequencer].length;
				for (; i<l; ++i) {
					if (_sequencers[sequencer][i] == event) {
						_sequencers[sequencer].splice(i, 1);
						if (_sequencers[sequencer].length == 0) {
							_sequencers[sequencer] = null;
							delete _sequencers[sequencer];
						}
						break;
					}
				}
			}
		}
		
		internal function unregisterSequencer(sequencer:ISequenceCommand):void {
			if (_sequencers[sequencer] != null && _sequencers[sequencer] != undefined) {
				if (_lastSequencer == sequencer) _lastSequencer = null;
				_sequencers[sequencer] = null;
				delete _sequencers[sequencer];
			}
		}
		
		internal function commandIsValid(CommandClass:Class):Boolean {
			return (new CommandClass() is ICommand);
		}
		
		//
		// PUBLIC
		//________________________________________________________________________________________________
		
		/**
		 * Indicates wether a command has been registered to the framework.
		 * @param commandName Event type that is used as a command name.
		 * @return A Boolean.
		 * @see com.soma.core.controller.SomaController
		 * @example
		 * <listing version="3.0">hasCommand(MyEvent.DOSOMETHING);</listing>
		 */
		public function hasCommand(commandName:String):Boolean {
			if (!_commands) return false;
			return !(_commands[commandName] == null || _commands[commandName] == undefined);
		}
		
		/**
		 * Registers a command to the framework.
		 * @param commandName Event type that is used as a command name.
		 * @param command Class that will be executed when a command has been dispatched.
		 * @see com.soma.core.controller.SomaController
		 * @example
		 * <listing version="3.0">addCommand(MyEvent.DOSOMETHING, MyCommand);</listing>
		 */
		public function addCommand(commandName:String, command:Class):void {
			if (!_commands) return;
			if (!commandIsValid(command)) {
				throw new Error("Error in " + this + " Command \"" + commandName + "\" must implement ICommand.");
			}
			if (hasCommand(commandName)) {
				throw new Error("Error in " + this + " Command \"" + commandName + "\" already registered.");
			}
			_commands[commandName] = command;
			addInterceptor(commandName);
		}
		
		/**
		 * Removes a command from the framework.
		 * @param commandName Event type that is used as a command name.
		 * @see com.soma.core.controller.SomaController
		 * @example
		 * <listing version="3.0">removeCommand(MyEvent.DOSOMETHING);</listing>
		 */
		public function removeCommand(commandName:String):void {
			if (!_commands) return;
			if (!hasCommand(commandName)) {
				throw new Error("Error in " + this + " Command \"" + commandName + "\" not registered.");
			}
			_commands[commandName] = null;
			delete _commands[commandName];
			removeInterceptor(commandName);
		}
		
		/**
		 * Retrieves the command class that has been registered with a command name.
		 * @param commandName Event type that is used as a command name.
		 * @return A class.
		 * @see com.soma.core.controller.SomaController
		 * @example
		 * <listing version="3.0">var commandClass:ICommand = getCommand(MyEvent.DOSOMETHING) as ICommand;</listing>
		 */
		public function getCommand(commandName:String):Class {
			if (!_commands) return null;
			if (!hasCommand(commandName)) return null;
			return _commands[commandName];
		}
		
		/**
		 * Retrieves the sequence command instance using an event instance that has been created from this sequence command.
		 * @param event Event instance.
		 * @return A sequencer (ISequenceCommand).
		 * @see com.soma.core.controller.SomaController
		 * @example
		 * <listing version="3.0">var sequencer:ISequenceCommand = getSequencer(myEvent);</listing>
		 */
		public function getCommands():Array {
			if (!_commands) return null;
			var array:Array = [];
			for (var command:String in _commands) {
				array.push(command);
			}
			return array;
		}
		
		/**
		 * Stops a sequence command using an event instance that has been created from this sequence command.
		 * @param event Event instance.
		 * @return A Boolean (true if a sequence command has been stopped).
		 * @see com.soma.core.controller.SomaController
		 * @example
		 * <listing version="3.0">var success:Boolean = stopSequencerWithEvent(myEvent);</listing>
		 */
		public function getSequencer(event:Event):ISequenceCommand {
			if (!_sequencers) return null;
			for (var sequencer:Object in _sequencers) {
				var i:Number = 0;
				var l:int = _sequencers[sequencer].length;
				for (; i<l; ++i) {
					if (_sequencers[sequencer][i] == event) {
						return sequencer as ISequenceCommand;
					}
				}
			}
			return null;
		}
		
		/**
		 * Stops a sequence command using an event instance that has been created from this sequence command.
		 * @param event Event instance.
		 * @return A Boolean (true if a sequence command has been stopped).
		 * @see com.soma.core.controller.SomaController
		 * @example
		 * <listing version="3.0">var success:Boolean = stopSequencerWithEvent(myEvent);</listing>
		 */
		public function stopSequencerWithEvent(event:Event):Boolean {
			if (!_sequencers) return false;
			for (var sequencer:Object in _sequencers) {
				var i:Number = 0;
				var l:int = _sequencers[sequencer].length;
				for (; i<l; ++i) {
					if (_sequencers[sequencer][i] == event) {
						ISequenceCommand(sequencer).stop();
						return true;
					}
				}
			}
			return false;
		}
		
		/**
		 * Stops a sequence command using the sequence command instance itself.
		 * @param sequencer The sequence command instance.
		 * @return A Boolean (true if the sequence command has been stopped).
		 * @see com.soma.core.controller.SomaController
		 * @example
		 * <listing version="3.0">var success:Boolean = stopSequencer(mySequenceCommand);</listing>
		 */
		public function stopSequencer(sequencer:ISequenceCommand):Boolean {
			if (sequencer == null) return false;
			sequencer.stop();
			return true;
		}
		
		/**
		 * Retrieves all the sequence command instances that are running.
		 * @return An Array of ISequenceCommand instances.
		 * @see com.soma.core.controller.SomaController
		 * @example
		 * <listing version="3.0">var sequencers:Array = getRunningSequencers();</listing>
		 */
		public function getRunningSequencers():Array {
			if (!_sequencers) return null;
			var array:Array = [];
			for (var sequencer:Object in _sequencers) {
				array.push(sequencer);
			}
			return array;
		}
		
		/**
		 * Stops all the sequences command instances that are running.
		 * @see com.soma.core.controller.SomaController
		 * @example
		 * <listing version="3.0">stopAllSequencers();</listing>
		 */
		public function stopAllSequencers():void {
			if (!_sequencers) return;
			for (var sequencer:Object in _sequencers) {
				ISequenceCommand(sequencer).stop();
			}
		}
		
		/**
		 * Indicates wether an event has been instantiated from a ISequenceCommand class.
		 * @return A Boolean.
		 * @see com.soma.core.controller.SomaController
		 * @example
		 * <listing version="3.0">var inSequence:Boolean = isPartOfASequence(myEvent);</listing>
		 */
		public function isPartOfASequence(event:Event):Boolean {
			if (!_sequencers) return false;
			return (getSequencer(event) != null);
		}
		
		/**
		 * Retrieves the last sequence command that has been instantiated in the framework.
		 * @return An ISequenceCommand instance.
		 * @see com.soma.core.controller.SomaController
		 * @example
		 * <listing version="3.0">var lastSequencer:ISequenceCommand = getLastSequencer();</listing>
		 */
		public function getLastSequencer():ISequenceCommand {
			return _lastSequencer;
		}
		
	}
}