package com.soma.core.demo.helloworld.controller.commands {
	
	import com.soma.core.demo.helloworld.models.MessageModel;
	import com.soma.core.demo.helloworld.controller.events.MessageEvent;
	import com.soma.core.interfaces.ICommand;
	import com.soma.core.controller.Command;
	import flash.events.Event;
	
	/**
	 * @author romuald
	 */
	public class MessageCommand extends Command implements ICommand {
		
		[Inject]
		public var model:MessageModel;
		
		public function execute(event:Event):void {
			switch (event.type) {
				case MessageEvent.REQUEST:
					model.requestMessage();
					break;
			}
		}
		
	}
}
