package com.soma.core.demo.twittersearch.services {
	import com.soma.core.demo.twittersearch.controller.events.TwitterEvent;
	import com.soma.core.interfaces.IWire;
	import com.soma.core.wire.Wire;
	import com.swfjunkie.tweetr.Tweetr;
	import com.swfjunkie.tweetr.events.TweetEvent;

	/**
	 * @author romuald
	 */
	public class TwitterService extends Wire implements IWire {
		
		private var _tweetr:Tweetr;
		private var _lastResult:Array;
		
		public static var count:int = 0;
		
		public function TwitterService() {
			
		}
		
		override public function initialize():void {
			_tweetr = new Tweetr();
			_tweetr.serviceHost = "http://labs.swfjunkie.com/tweetr/proxy";
			_tweetr.addEventListener(TweetEvent.COMPLETE, resultHandler);
			_tweetr.addEventListener(TweetEvent.FAILED, faultHandler);
		}

		private function faultHandler(event:TweetEvent):void {
			trace("fault");
		}

		private function resultHandler(event:TweetEvent):void {
			_lastResult = event.responseArray;
			dispatchEvent(new TwitterEvent(TwitterEvent.SEARCH_RESULT));
		}
		
		public function search(keywords:String):void {
			_tweetr.search(keywords, null, 30, 1);
		}

		public function get lastResult():Array {
			return _lastResult;
		}
		
	}
}
