package com.soundstep.somacolor.wires {
	import com.soma.core.interfaces.ISequenceCommand;
	import com.soma.core.interfaces.IWire;
	import com.soma.core.wire.Wire;
	import com.soundstep.somacolor.controllers.events.TweenSequenceEvent;
	import com.soundstep.somacolor.models.ColorModel;
	import com.soundstep.somacolor.views.ColorReceiver;
	import com.soundstep.somacolor.views.ColorSelector;
	import com.soundstep.somacolor.views.ColorSquare;
	import com.soundstep.somacolor.vo.ColorVO;

	import flash.events.Event;
	import flash.geom.ColorTransform;

	/**
	 * <b>Author:</b> Romuald Quantin - <a href="http://www.soundstep.com/" target="_blank">www.soundstep.com</a><br />* <b>Class version:</b> 1.0<br />
	 * <b>Actionscript version:</b> 3.0<br />
	 * <b>Copyright:</b> 
	 * <br />
	 * <b>Date:</b> Sep 18, 2009<br />
	 * <b>Usage:</b>
	 * @example
	 * <listing version="3.0"></listing>
	 */
	
	public class ColorWire extends Wire implements IWire {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		private var _lastSequencer:ISequenceCommand;
		
		//------------------------------------
		// public properties
		//------------------------------------
		
		[Inject]
		public var model:ColorModel;
		
		[Inject]
		public var receiver:ColorReceiver;
		
		[Inject]
		public var selector:ColorSelector;
		
		[Inject]
		public var square:ColorSquare;
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		public function ColorWire() {
			
		}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		override public function initialize():void {
			stage.addChild(receiver);
			stage.addChild(selector);
			stage.addChild(square);
			square.x = 20;
			square.y = 300;
			receiver.addEventListener(ColorReceiver.START_TWEEN_SEQUENCE_EVENT, startTweenSequenceHandler);
		}
		
		private function startTweenSequenceHandler(e:Event):void {
			if (_lastSequencer != null) _lastSequencer.stop();
			dispatchEvent(new TweenSequenceEvent(TweenSequenceEvent.SEQUENCE));
			_lastSequencer = getLastSequencer();
		}
		
		override public function dispose():void {
			
		}
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		public function updateReceiverColor(color:uint):void {
			receiver.graphics.clear();
			receiver.graphics.beginFill(color, .3);
			receiver.graphics.drawRect(0, 0, 500, 400);
			receiver.graphics.endFill();
		}
		
		public function updateSquareColor(color:uint):void {
			var ct:ColorTransform = new ColorTransform();
			ct.color = color;
			square.transform.colorTransform = ct;
		}
		
		public function loadColorData():void {
			model.loadData();
		}
		
		public function updateViews():void {
			selector.updateColors(ColorVO(model.data));
			updateReceiverColor(ColorVO(model.data).color1);
			updateSquareColor(ColorVO(model.data).color1);
		}
		
	}
}