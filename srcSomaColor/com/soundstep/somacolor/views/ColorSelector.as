package com.soundstep.somacolor.views {
	import com.bit101.components.PushButton;
	import com.soundstep.somacolor.controllers.events.ColorDataEvent;
	import com.soundstep.somacolor.controllers.events.ColorEvent;
	import com.soundstep.somacolor.controllers.events.MoveViewEvent;
	import com.soundstep.somacolor.controllers.events.SequenceEvent;
	import com.soundstep.somacolor.vo.ColorVO;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	/**
	 * <b>Author:</b> Romuald Quantin - <a href="http://www.soundstep.com/" target="_blank">www.soundstep.com</a><br />* <b>Class version:</b> 1.0<br />
	 * <b>Actionscript version:</b> 3.0<br />
	 * <b>Copyright:</b> 
	 * <br />
	 * <b>Date:</b> Sep 17, 2009<br />
	 * <b>Usage:</b>
	 * @example
	 * <listing version="3.0"></listing>
	 */
	
	public class ColorSelector extends Sprite {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		private var _sprite1:Sprite; 
		private var _sprite2:Sprite; 
		private var _sprite3:Sprite; 
		
		private var _color1:uint;
		private var _color2:uint;
		private var _color3:uint;

		//------------------------------------
		// public properties
		//------------------------------------
		
		public var offsetX:Number = 10;
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		public function ColorSelector() {
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
			stage.addEventListener(Event.RESIZE, updateLayout);
			// bg 
			graphics.beginFill(0xC6BAA6, .3);
			graphics.drawRect(0, 0, 130, 170);
			// colors
			_sprite1 = addChild(new Sprite) as Sprite;
			_sprite1.x = 10;
			_sprite1.y = 10;
			_sprite1.addEventListener(MouseEvent.CLICK, mouseClickHandler);
			_sprite1.buttonMode = true;
			_sprite1.mouseChildren = false;
			
			_sprite2 = addChild(new Sprite) as Sprite;
			_sprite2.x = 50;
			_sprite2.y = 10;
			_sprite2.addEventListener(MouseEvent.CLICK, mouseClickHandler);
			_sprite2.buttonMode = true;
			_sprite2.mouseChildren = false;
			
			_sprite3 = addChild(new Sprite) as Sprite;
			_sprite3.x = 90;
			_sprite3.y = 10;
			_sprite3.addEventListener(MouseEvent.CLICK, mouseClickHandler);
			_sprite3.buttonMode = true;
			_sprite3.mouseChildren = false;
			
			var btRandomColor:PushButton = new PushButton(this, 10, 50, "Random Color", randomColorHandler);
			btRandomColor.width = 110;
			var btMoveView:PushButton = new PushButton(this, 10, 80, "Move View", moveViewHandler);
			btMoveView.width = 110;
			var btResetView:PushButton = new PushButton(this, 10, 110, "Reset View", resetViewHandler);
			btResetView.width = 110;
			var btLoadData:PushButton = new PushButton(this, 10, 140, "Load Data", loadDataHandler);
			btLoadData.width = 110;
			
			updateLayout();
		}
		
		private function mouseClickHandler(e:MouseEvent):void {
			var color:uint;
			switch (e.currentTarget) {
				case _sprite1:
					color = _color1;
					break;
			}
			switch (e.currentTarget) {
				case _sprite2:
					color = _color2;
					break;
			}
			switch (e.currentTarget) {
				case _sprite3:
					color = _color3;
					break;
			}
			dispatchEvent(new ColorEvent(ColorEvent.CHANGE_COLOR, color));
		}
		
		private function randomColorHandler(e:MouseEvent):void {
			dispatchEvent(new ColorEvent(ColorEvent.CHANGE_COLOR, Math.random() * 0xFFFFFF));
		}
		
		private function moveViewHandler(e:MouseEvent):void {
			var newX:Number = Math.round(Math.random() * 100 + 10);
			var newY:Number = Math.round(Math.random() * 100 + 10);
			dispatchEvent(new MoveViewEvent(MoveViewEvent.MOVE_VIEW, newX, newY));
		}

		private function resetViewHandler(e:MouseEvent):void {
			dispatchEvent(new SequenceEvent(SequenceEvent.STOP_ALL_SEQUENCES));
			dispatchEvent(new ColorEvent(ColorEvent.CHANGE_COLOR, _color1));
			dispatchEvent(new MoveViewEvent(MoveViewEvent.MOVE_VIEW, 10, 10));
		}
		
		private function loadDataHandler(e:MouseEvent):void {
			dispatchEvent(new ColorDataEvent(ColorDataEvent.LOAD));
		}

		private function updateLayout(e:Event = null):void {
			x = stage.stageWidth - width - offsetX;
			y = 10;
		}
		
		private function draw():void {
			_sprite1.graphics.clear();
			_sprite1.graphics.beginFill(_color1, 1);
			_sprite1.graphics.drawRect(0, 0, 30, 30);
			_sprite1.graphics.endFill();
			_sprite2.graphics.clear();
			_sprite2.graphics.beginFill(_color2, 1);
			_sprite2.graphics.drawRect(0, 0, 30, 30);
			_sprite2.graphics.endFill();
			_sprite3.graphics.clear();
			_sprite3.graphics.beginFill(_color3, 1);
			_sprite3.graphics.drawRect(0, 0, 30, 30);
			_sprite3.graphics.endFill();
		}
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		public function dispose():void {
			
		}
		
		public function updateColors(data:ColorVO):void {
			_color1 = data.color1;
			_color2 = data.color2;
			_color3 = data.color3;
			draw();
		}
		
	}
}
