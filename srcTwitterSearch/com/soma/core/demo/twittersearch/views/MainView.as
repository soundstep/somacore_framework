package com.soma.core.demo.twittersearch.views {
	import com.bit101.components.InputText;
	import com.bit101.components.PushButton;
	import com.soma.core.demo.twittersearch.controller.events.TwitterEvent;

	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFormat;

	/**
	 * @author romuald
	 */
	public class MainView extends Sprite {
		
		private var _search:PushButton;		private var _input:InputText;
		private var _textfield:TextField;
		
		public function MainView() {
			initialize();
		}

		private function initialize():void {
			_search = new PushButton(this, 10, 10, "SEARCH", clickHandler);
			_textfield = new TextField();
			_textfield.defaultTextFormat = new TextFormat("_typewriter", 11);
			_textfield.antiAliasType = AntiAliasType.ADVANCED;
			_textfield.width = 400;
			_textfield.height = 300;
			_textfield.multiline = true;			_textfield.wordWrap = true;
			_textfield.x = 10;			_textfield.y = 40;
			addChild(_textfield);
			_input = new InputText(this, 120, 12, "soundstep");
		}

		private function clickHandler(event:MouseEvent):void {
			dispatchEvent(new TwitterEvent(TwitterEvent.SEARCH, _input.text));
		}

		public function get search():PushButton {
			return _search;
		}

		public function get input():InputText {
			return _input;
		}

		public function get textfield():TextField {
			return _textfield;
		}

		public function setText(value:String):void {
			_textfield.htmlText = value;
		}
		
		public function appendText(value:String):void {
			_textfield.htmlText += value;
		}
		
	}
}
