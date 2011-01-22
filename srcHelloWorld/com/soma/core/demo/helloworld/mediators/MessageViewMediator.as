package com.soma.core.demo.helloworld.mediators {
	import com.soma.core.demo.helloworld.controller.events.MessageEvent;
	import com.soma.core.demo.helloworld.views.MessageView;
	import com.soma.core.interfaces.IMediator;
	import com.soma.core.mediator.Mediator;

	/**
	 * @author romualdq
	 */
	public class MessageViewMediator extends Mediator implements IMediator {
		
		[Inject]
		public var view:MessageView;
		
		private function messageReady(event:MessageEvent):void {
			view.updateMessage(event.message);
		}
		
		override public function initialize():void {
			addEventListener(MessageEvent.READY, messageReady);
		}

		override public function dispose():void {
			removeEventListener(MessageEvent.READY, messageReady);
		}

	}
}
