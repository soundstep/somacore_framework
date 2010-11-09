package com.soma.core.demo.twittersearch.wires {
	import com.soma.core.demo.twittersearch.controller.events.TwitterEvent;
	import com.soma.core.demo.twittersearch.services.TwitterService;
	import com.soma.core.demo.twittersearch.views.MainView;
	import com.soma.core.interfaces.IWire;
	import com.soma.core.wire.Wire;
	import com.swfjunkie.tweetr.data.objects.SearchResultData;

	/**
	 * @author romuald
	 */
	public class SearchWire extends Wire implements IWire {
		
		[Inject]
		public var service:TwitterService;
		
		[Inject]
		public var view:MainView;
		
		public function SearchWire() {
			
		}
		
		override public function initialize():void {
			// view
			stage.addChild(view);
			// listeners
			addEventListener(TwitterEvent.SEARCH, searchHandler);
			addEventListener(TwitterEvent.SEARCH_RESULT, resultHandler);
		}

		private function searchHandler(event:TwitterEvent):void {
			view.setText("Search for \"" + event.keywords + "\"... Please wait.");
		}

		private function resultHandler(event:TwitterEvent):void {
			view.setText("");
			var i:Number = 0;
			var l:Number = service.lastResult.length;
			for (; i<l; ++i) {
				var result:SearchResultData = service.lastResult[i];
				view.appendText("--------------------------<br/>");
				view.appendText(result.text + "<br/>");
			}
		}

	}
}
