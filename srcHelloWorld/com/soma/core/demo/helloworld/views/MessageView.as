package com.soma.core.demo.helloworld.views {
	import flash.events.MouseEvent;
	import com.soma.core.demo.helloworld.controller.events.MessageEvent;
	import flash.text.TextField;
	import flash.display.Sprite;

	/**
	 * @author romuald
	 */
	public class MessageView extends Sprite {
		
		private var _textfield:TextField;
		
		public function MessageView() {
			_textfield = new TextField();
			_textfield.text = "Click me!";
			_textfield.addEventListener(MouseEvent.CLICK, clicked);
			addChild(_textfield);
		}

		private function clicked(event:MouseEvent):void {
			dispatchEvent(new MessageEvent(MessageEvent.REQUEST));
		}

		public function updateMessage(value:String):void {
			_textfield.text = value;
		}
		
	}
}
