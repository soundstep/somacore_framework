/**
 * The contents of this file are subject to the Mozilla Public License
 * Version 1.1 (the "License"); you may not use this file except in compliance
 * with the License. You may obtain a copy of the License at
 * 
 * http://www.mozilla.org/MPL/
 * 
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied.
 * See the License for the specific language governing rights and
 * limitations under the License.
 * 
 * The Original Code is SomaDebugger.
 * 
 * The Initial Developer of the Original Code is Romuald Quantin.
 * romu@soundstep.com (www.soundstep.com).
 * 
 * Portions created by
 * 
 * Initial Developer are Copyright (C) 2008-2010 Soundstep. All Rights Reserved.
 * All Rights Reserved.
 * 
 */
 
 package com.soma.debugger.views {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.system.System;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.getTimer;

	/**
	 * <b>Author:</b> Romuald Quantin - <a href="http://www.soundstep.com/" target="_blank">www.soundstep.com</a><br />
	 * <b>Class version:</b> v1.0.1<br />
	 * <b>Actionscript version:</b> 3.0<br />
	 * <b>Copyright:</b>
	 * Mozilla Public License 1.1 (MPL 1.1)<br /> 
	 * <a href="http://www.opensource.org/licenses/mozilla1.1.php" target="_blank">http://www.opensource.org/licenses/mozilla1.1.php</a><br />
	 * <br />
	 * <b>Usage:</b><br />
	 * @example
	 * <listing version="3.0">
	 * </listing>
	 */
	
    public class SomaDebuggerStats extends Sprite {
		
		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		private var _barColor:uint;
		private var _bgColor:uint;
		private var _textColor:uint;
		private var _bgAlpha:uint;
        private var _bar:Sprite;
        private var _bg:Sprite;
        private var _text:TextField;
        private var _time:Number;
        private var _frameTime:Number;
        private var _prevFrameTime:Number = getTimer();
        private var _secondTime:Number;
        private var _prevSecondTime:Number = getTimer();
        private var _frames:Number = 0;
        private var _fps:String = "...";
        private var _other:String = "";
        private var _memory:String;
        private var _typeMemory:uint;
        private var _arrayKey:Array;
        private var _widthBar:Number;        private var _heightBar:Number;
		
		//------------------------------------
		// public properties
		//------------------------------------
		
		public static const MEMORY_BYTES:uint = 1;
		public static const MEMORY_KILOBYTES:uint = 2;
		public static const MEMORY_MEGABYTES:uint = 3;
		
		//------------------------------------
		// constructor
		//------------------------------------
        
		/**
		 * Constructor
		 * @param bgColor background color
		 * @param barColor color of the bar that displays the information
		 * @param textColor text color that displays the information
		 * @param bgAlpha alpha of the background
		 * @param typeMemory type of the memory displayed (bytes, kilobytes, megabytes)
		 */
        public function SomaDebuggerStats(widthBar:Number = 500, heightBar:Number = 15, bgColor:uint = 0xCCCCCC, barColor:uint = 0xFFFFFF, textColor:uint = 0x333333, bgAlpha:Number = 1, typeMemory:uint = 2, barVisible:Boolean = true) {
			_widthBar = widthBar;
			_heightBar = heightBar;
			_bgColor = bgColor;
			_barColor = barColor;
			_textColor = textColor;
			_bgAlpha = bgAlpha;
            _typeMemory = typeMemory;
            visible = barVisible;
			addEventListener(Event.ADDED_TO_STAGE, init, false, 0, true);
			addEventListener(MouseEvent.CLICK, clickHandler, false, 0, true);
        }
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		private function init(e:Event):void {
			_arrayKey = [];
			removeEventListener(Event.ADDED_TO_STAGE, init, false);
			_bg = new Sprite();
            _bg.graphics.beginFill(_bgColor, 1);
            _bg.graphics.drawRect(0, 0, _widthBar, _heightBar);
			_bg.graphics.endFill();
            _bg.alpha = _bgAlpha;
            addChild(_bg);
            _bar = new Sprite();
            _bar.graphics.beginFill(_barColor, 1);
            _bar.graphics.drawRect(0, 0, 25, _heightBar);
            _bar.graphics.endFill();
            addChild(_bar);
            _text = new TextField();
            var tf:TextFormat = new TextFormat("_typewriter", 10);
            _text.defaultTextFormat = tf;
            _text.y +=1;
            _text.autoSize=TextFieldAutoSize.LEFT;
            _text.textColor = _textColor;
            _text.selectable = false;
            addChild(_text);
            addEventListener(Event.ENTER_FRAME, onEnterFrame, false, 0, true);
		}
		
		private function clickHandler(e:MouseEvent):void {
			if (e.target == e.currentTarget) {
				e.stopImmediatePropagation();
				visible = false;
			}
		}
		
        private function onEnterFrame(e:Event):void {
            _time = getTimer();
            _frameTime = _time - _prevFrameTime;
            _secondTime = _time - _prevSecondTime;
            if(_secondTime >= 1000){
                _fps = _frames.toString();
                _frames = 0;
                _prevSecondTime = _time;
			}
			else _frames++;
            _prevFrameTime = _time;
            if(_typeMemory == MEMORY_BYTES){
                _memory = flash.system.System.totalMemory.toPrecision(4);
                _memory = convert(Number(_memory)) + " bytes";
            }
			else if(_typeMemory == MEMORY_KILOBYTES){
                _memory = (flash.system.System.totalMemory / 1000).toPrecision(4);
                _memory = convert(Number(_memory)) + " kbs";
            }
			else if (_typeMemory ==  MEMORY_MEGABYTES){
                _memory = (flash.system.System.totalMemory / 1000000).toPrecision(4);
                _memory = convert(Number(_memory)) + " mbs";
            }
            _text.htmlText = "Framerate: "+ _fps +" fps / "+ _frameTime +"ms - Memory: "+ _memory +" - "+ _other.toString();
            _bar.scaleX = _bar.scaleX - ((_bar.scaleX - (_frameTime/10)) / 5);
        }
        
        private function convert(value:Number):Number {
        	return Math.round(value * Math.pow(10, 2)) / Math.pow(10, 2);
        }
        
		// PUBLIC
		//________________________________________________________________________________________________
		
		/**
		 * Add a value to show in the bar
		 * @param value
		 */
        public function add(value:String):void {
            _other = value;
		}
		
		public function get memory():uint {
			return _typeMemory;
		}
		
		public function set memory(typeMemory:uint):void {
			_typeMemory = typeMemory;
		}
	}
}
