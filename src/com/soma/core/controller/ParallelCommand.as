package com.soma.core.controller {
	import com.soma.core.interfaces.IParallelCommand;

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
	
	public class ParallelCommand extends Command implements IParallelCommand {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		private var _commands:Array;

		//------------------------------------
		// public properties
		//------------------------------------
		
		
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		public function ParallelCommand() {
			
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
		}
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		public final function execute(event:Event):void {
			while (_commands.length > 0) {
				var command:Event = _commands.shift();
				if (hasCommand(command.type)) soma.dispatchEvent(command);
			}
			_commands = null;
		}
		
		public final function get length():int {
			if (_commands == null) return -1;
			return _commands.length;
		}
		
		public final function get commands():Array {
			return _commands;
		}
	}
}