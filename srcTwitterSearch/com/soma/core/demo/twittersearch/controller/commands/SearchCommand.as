package com.soma.core.demo.twittersearch.controller.commands {
	import com.soma.core.demo.twittersearch.wires.SearchWire;
	import com.soma.core.demo.twittersearch.services.TwitterService;
	import com.soma.core.controller.Command;
	import com.soma.core.demo.twittersearch.controller.events.TwitterEvent;
	import com.soma.core.interfaces.ICommand;

	import flash.events.Event;

	/**
	 * @author romuald
	 */
	public class SearchCommand extends Command implements ICommand {
		
		[Inject]
		public var service:TwitterService;
		
		public function execute(event:Event):void {
			switch (event.type) {
				case TwitterEvent.SEARCH:
					service.search(TwitterEvent(event).keywords);
					break;
			}
		}
		
	}
}
