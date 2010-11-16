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
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;

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
	
	public class SomaDebuggerScrollbar extends Sprite {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		private var _textfield:TextField;
		
		private var _track:Sprite;
		private var _grip:Sprite;
		private var _dragBounds:Rectangle;
		private var _isDragging:Boolean;
		private var _isClicking:Boolean;
		private var _scrollAmount:Number;
		private var _scrollCount:Number;
		
		//------------------------------------
		// public properties
		//------------------------------------
		
		

		//------------------------------------
		// constructor
		//------------------------------------
		
		public function SomaDebuggerScrollbar(textfield:TextField) {
			_textfield = textfield;
			addEventListener(Event.ADDED_TO_STAGE, added, false, 0, true);
		}

		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		private function added(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, added, false);
			initialize();
		}
		
		private function initialize():void {
			stage.addEventListener(Event.MOUSE_LEAVE, stageLeavehandler);
			stage.addEventListener(MouseEvent.MOUSE_UP, mouseClean);
			_textfield.addEventListener(Event.SCROLL, scrollEventHandler);
			_scrollAmount = 4;
			_scrollCount = 0;
			_isDragging = false;
			_isClicking = false;
			createTrack();
			createScrollbar();
			updateLayout();
		}
		
		private function createTrack():void {
			_track = addChild(new Sprite) as Sprite;
			_track.addEventListener(MouseEvent.MOUSE_DOWN, trackClickHandler);			_track.addEventListener(MouseEvent.MOUSE_UP, trackClickHandler);			_track.addEventListener(MouseEvent.MOUSE_OUT, mouseClean);
			addChild(_track);
		}
		
		private function createScrollbar():void {
			_grip = new Sprite();
			_grip.visible = false;
			_grip.graphics.beginFill(0xFF0000, 0); 
			_grip.graphics.drawRect(0, 0, 3, 30);
			_grip.graphics.beginFill(0x363636); 
			_grip.graphics.drawRect(3, 0, 10, 30);
			_grip.graphics.beginFill(0xFF0000, 0); 
			_grip.graphics.drawRect(8, 0, 3, 30);
			_grip.graphics.endFill();
			addChild(_grip);
			_grip.buttonMode = true;
			_grip.mouseChildren = false;
			_grip.addEventListener(MouseEvent.MOUSE_DOWN, gripMouseDownHandler);
		}
		
		private function scrollEventHandler(e:Event):void {
			var percent:Number = (_textfield.scrollV-1) / (_textfield.maxScrollV-1);
			if (!_isDragging && !_isClicking) {
				_grip.y = _dragBounds.height * percent;
			}
			if (_textfield.textHeight > _textfield.height) _grip.visible = true;
		}
		
		private function trackClickHandler(e:MouseEvent):void {
			if (_textfield.textHeight < _textfield.height) return;
			switch (e.type) {
				case MouseEvent.MOUSE_DOWN:
					_isClicking = true;
					addEventListener(Event.ENTER_FRAME, scrollGripHandler);
					break;
				case MouseEvent.MOUSE_UP:
					_isClicking = false;
					removeScrollGripHandler();
					break;
			}
		}
		
		private function removeScrollGripHandler():void {
			removeEventListener(Event.ENTER_FRAME, scrollGripHandler);
			_scrollCount = 0;
			stopDragAndClean();
		}
		
		private function scrollGripHandler(e:Event):void {
			if (_scrollCount++ % _scrollAmount != 0) return;
			var point:Point = _grip.localToGlobal(new Point(_grip.mouseX, _grip.mouseY));
			if (_grip.hitTestPoint(point.x, point.y)) {
				removeScrollGripHandler();
				return;
			}
			var gripVal:Number = _grip.y + (_grip.height*.5);
			if (_track.mouseY > gripVal) {
				_grip.y += (_track.height / 10);
				if (_grip.y > _dragBounds.height) _grip.y = _dragBounds.height;
			}
			else {
				_grip.y -= (_track.height / 10);
				if (_grip.y < 0) _grip.y = 0;
			}
			moveHandler();
			if (_textfield.scrollV == 1 || _textfield.scrollV == _textfield.maxScrollV) {
				removeScrollGripHandler();
			}
		}

		private function updateLayout():void {
			_track.graphics.clear();
			_track.graphics.beginFill(0x9B9B9B); 
			_track.graphics.drawRect(0, 0, 10, _textfield.height);
			_track.graphics.endFill();
			x = _textfield.x + _textfield.width;
			y = _textfield.y;
			_grip.x = _track.x - 3;
			_grip.y = _track.y;
			_dragBounds = new Rectangle(_grip.x, _grip.y, 0, _track.height - _grip.height);
		}

		private function gripMouseDownHandler(e:MouseEvent):void {
			switch (e.type) {
				case MouseEvent.MOUSE_DOWN:
					addEventListener(Event.ENTER_FRAME, moveHandler);
					_isDragging = true;
					_grip.startDrag(false, _dragBounds);
					break;
			}
		}
		
		private function mouseClean(e:MouseEvent):void {
			stopDragAndClean();
		}

		private function stageLeavehandler(e:Event):void {
			stopDragAndClean();
		}

		private function stopDragAndClean():void {
			_isDragging = false;
			_isClicking = false;
			_grip.stopDrag();
			removeEventListener(Event.ENTER_FRAME, moveHandler);
			removeEventListener(Event.ENTER_FRAME, scrollGripHandler);
		}
		
		private function moveHandler(e:Event = null):void {
			_textfield.scrollV = _textfield.maxScrollV * _grip.y / _dragBounds.height;
		}

		// PUBLIC
		//________________________________________________________________________________________________
		
		public function get isDragging():Boolean {
			return _isDragging;
		}
		
		public function dispose() : void {
			// dispose objects, graphics and events listeners
			try {
				removeEventListener(Event.ADDED_TO_STAGE, added, false);
				stage.removeEventListener(Event.MOUSE_LEAVE, stageLeavehandler);
				stage.removeEventListener(MouseEvent.MOUSE_UP, mouseClean);
				_textfield.removeEventListener(Event.SCROLL, scrollEventHandler);
				_track.removeEventListener(MouseEvent.MOUSE_DOWN, trackClickHandler);
				_track.removeEventListener(MouseEvent.MOUSE_UP, trackClickHandler);
				_track.removeEventListener(MouseEvent.MOUSE_OUT, mouseClean);
				_grip.removeEventListener(MouseEvent.MOUSE_DOWN, gripMouseDownHandler);
				removeEventListener(Event.ENTER_FRAME, scrollGripHandler);
				removeEventListener(Event.ENTER_FRAME, moveHandler);
				while (numChildren > 0) removeChildAt(0);
				_track = null;
				_grip = null;
			} catch(e:Error) {
				trace("Error in", this, "(dispose method):", e.message);
			}
		}
		
	}
}
