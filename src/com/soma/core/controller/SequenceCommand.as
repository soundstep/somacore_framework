package com.soma.core.controller {
	import com.soma.core.interfaces.ISequenceCommand;

	import flash.events.Event;

	/**
	 * <b>Author:</b> Romuald Quantin - <a href="http://www.soundstep.com/" target="_blank">www.soundstep.com</a><br />* <b>Class version:</b> 1.0<br />
	 * <b>Actionscript version:</b> 3.0<br />
	 * <b>Copyright:</b> 
	 * <br />
	 * <b>Date:</b> Sep 22, 2009<br />
	 * <b>Usage:</b>
	 * @example
	 * <listing version="3.0"></listing>
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
			soma.controller.registerSequencedCommand(this, event);
		}
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		public final function execute(event:Event):void {
			if (_commands == null) return;
			_currentCommand = _commands.shift();
			if (hasCommand(_currentCommand.type)) soma.dispatchEvent(_currentCommand);
		}
		
		public final function executeNextCommand():void {
			if (_commands == null) return;
			soma.controller.unregisterSequencedCommand(this, _currentCommand);
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
			soma.controller.unregisterSequencer(this);
		}
		
		public final function get currentCommand():Event {
			return _currentCommand;
		}
		
		public final function get commands():Array {
			return _commands;
		}
	}
}