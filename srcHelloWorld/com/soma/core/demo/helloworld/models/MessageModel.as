package com.soma.core.demo.helloworld.models {
	import com.soma.core.demo.helloworld.controller.events.MessageEvent;
	import com.soma.core.demo.helloworld.wires.MessageWire;
	import com.soma.core.interfaces.IModel;
	import com.soma.core.model.Model;

	/**
	 * @author romuald
	 */
	public class MessageModel extends Model implements IModel {
		
		private var _message:String = "Hello SomaCore!";
		
		public static const NAME:String = "APP:MessageModel";
		
		[Inject]
		public var wire:MessageWire;
		
		public function MessageModel() {
			super(NAME);
		}
		
		override protected function initialize():void {
			trace("POST")
			_message = "Hello SomaCore INITIALIZED!";
		}

		public function requestMessage():void {
			var event:MessageEvent = new MessageEvent(MessageEvent.READY);
			event.message = _message;
			trace(0, event.message)
			dispatchEvent(event);
		}
		
	}
}
