package com.cafetownsend.commands
{
	import com.soma.core.controller.Command;
	import com.soma.core.interfaces.ICommand;
	
	import flash.events.Event;

	public class StartCommand extends Command implements ICommand {
		
		public function StartCommand() {
			super();
		}
		
		public function execute(event:Event):void {
			// anything if you want to start your app from here
		}
		
	}
}