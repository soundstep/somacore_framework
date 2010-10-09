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
		
		public function dispose() : void {
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
			_instance.stage.addEventListener(commandName, eventsHandler, true, -100);
			_instance.addEventListener(commandName, somaEventsHandler, false, -100);
		}
		
		private function removeInterceptor(commandName:String):void {
			if (_instance.stage == null) return;
			_instance.stage.removeEventListener(commandName, eventsHandler, true);
			_instance.removeEventListener(commandName, somaEventsHandler, false);
		}
		
		private function eventsHandler(event:Event):void {
			if (event.bubbles && hasCommand(event.type)) {
				event.stopPropagation();
				var clonedEvent:Event = event.clone();
				// store a reference of the events not to dispatch it twice
				_lastEvent = clonedEvent;
				_instance.dispatchEvent(clonedEvent);
				if (!clonedEvent.isDefaultPrevented()) {
					executeCommand(event);
				}
				_lastEvent = null;
			}
		}
		
		private function somaEventsHandler(event:Event):void {
			// if the event is equal to the lastEvent, this has already been dispatched for execution
			if (_lastEvent != event) {
				if (!event.isDefaultPrevented()) {
					executeCommand(event);
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
			if (_sequencers[sequencer] != null && _sequencers[sequencer] != undefined) {
				var len:int = _sequencers[sequencer].length;
				for (var i:int=0; i<len; i++) {
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
				_sequencers[sequencer] = null;
				delete _sequencers[sequencer];
			}
		}
		
		//
		// PUBLIC
		//________________________________________________________________________________________________
		
		public function hasCommand(commandName:String):Boolean {
			if (!_commands) return false;
			return !(_commands[commandName] == null || _commands[commandName] == undefined);
		}
		
		public function addCommand(commandName:String, command:Class):void {
			if (!_commands) return;
			if (hasCommand(commandName)) {
				throw new Error("Error in " + this + " Command \"" + commandName + "\" already registered.");
			}
			_commands[commandName] = command;
			addInterceptor(commandName);
		}
		
		public function removeCommand(commandName:String):void {
			if (!_commands) return;
			if (!hasCommand(commandName)) {
				throw new Error("Error in " + this + " Command \"" + commandName + "\" not registered.");
			}
			_commands[commandName] = null;
			delete _commands[commandName];
			removeInterceptor(commandName);
		}
		
		public function getCommand(commandName:String):Class {
			if (!_commands) return null;
			if (!hasCommand(commandName)) return null;
			return _commands[commandName];
		}
		
		public function getCommands():Array {
			if (!_commands) return null;
			var array:Array = [];
			for (var command:String in _commands) {
				array.push(command);
			}
			return array;
		}
		
		public function getSequencer(event:Event):ISequenceCommand {
			if (!_sequencers) return null;
			for (var sequencer:Object in _sequencers) {
				var len:int = _sequencers[sequencer].length;
				for (var i:int=0; i<len; i++) {
					if (_sequencers[sequencer][i] == event) {
						return sequencer as ISequenceCommand;
					}
				}
			}
			return null;
		}
		
		public function stopSequencerWithEvent(event:Event):Boolean {
			if (!_sequencers) return false;
			for (var sequencer:Object in _sequencers) {
				var len:int = _sequencers[sequencer].length;
				for (var i:int=0; i<len; i++) {
					if (_sequencers[sequencer][i] == event) {
						ISequenceCommand(sequencer).stop();
						return true;
					}
				}
			}
			return false;
		}
		
		public function stopSequencer(sequencer:ISequenceCommand):Boolean {
			if (sequencer == null) return false;
			sequencer.stop();
			return true;
		}
		
		public function getRunningSequencers():Array {
			if (!_sequencers) return null;
			var array:Array = [];
			for (var sequencer:Object in _sequencers) {
				array.push(sequencer);
			}
			return array;
		}
		
		public function stopAllSequencers():void {
			if (!_sequencers) return;
			for (var sequencer:Object in _sequencers) {
				ISequenceCommand(sequencer).stop();
			}
		}
		
		public function isPartOfASequence(event:Event):Boolean {
			if (!_sequencers) return false;
			return (getSequencer(event) != null);
		}
		
		public function getLastSequencer():ISequenceCommand {
			return _lastSequencer;
		}
		
	}
}