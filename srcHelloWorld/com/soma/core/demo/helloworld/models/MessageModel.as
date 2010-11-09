package com.soma.core.demo.helloworld.models {
	import com.soma.core.demo.helloworld.controller.events.MessageEvent;
	import com.soma.core.interfaces.IModel;
	import com.soma.core.model.Model;

	/**
	 * @author romuald
	 */
	public class MessageModel extends Model implements IModel {
		
		private var _message:String;
		
		public static const NAME:String = "APP:MessageModel";
		
		public function MessageModel() {
			super(NAME);
		}
		
		override public function initialize():void {
			_message = "Hello SomaCore!";
		}

		public function requestMessage():void {
			var event:MessageEvent = new MessageEvent(MessageEvent.READY);
			event.message = _message;
			dispatchEvent(event);
		}
		
	}
}
