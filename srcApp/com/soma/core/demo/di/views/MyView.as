package com.soma.core.demo.di.views {

	import flash.events.KeyboardEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	/**
	 * @author Romuald Quantin
	 */
	public class MyView extends Sprite {

		private var _textfield:TextField;
		
		public static var count:int = 0;
		
		private var _id:int;
		
		public function MyView() {
			_id = ++count; 
			addEventListener(Event.ADDED_TO_STAGE, added);
		}

		private function added(event:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, added);
			graphics.beginFill(Math.random() * 0xFF0000, 0.5);
			graphics.drawRect(0, 0, 50, 50);
			x = Math.random() * stage.stageWidth;			y = Math.random() * stage.stageHeight;
			_textfield = new TextField();
			_textfield.defaultTextFormat = new TextFormat("_typewriter", 11);
			_textfield.antiAliasType = AntiAliasType.ADVANCED;
			_textfield.autoSize = TextFieldAutoSize.LEFT;
			_textfield.selectable = false;
			_textfield.text = count.toString();
			addChild(_textfield);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyboardHandler);
		}

		private function keyboardHandler(event:KeyboardEvent):void {
			trace(this, _id, event.keyCode);
		}

		public function get id():int {
			return _id;
		}
		
		public function dispose() : void {
			// dispose objects, graphics and events listeners
			try {
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyboardHandler);
				trace(this, _id, "dispose");
				while (numChildren > 0) removeChildAt(0);
			} catch(e:Error) {
				trace("Error in", this, "(dispose method):", e.message);
			}
		}
		
	}
}
