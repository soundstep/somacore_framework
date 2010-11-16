package com.soundstep.somacolor.views {
	import com.bit101.components.PushButton;
	import com.soundstep.somacolor.controllers.events.ASyncEvent;
	import com.soundstep.somacolor.controllers.events.ChainEvent;
	import com.soundstep.somacolor.controllers.events.SequenceEvent;

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
	
	public class ColorReceiver extends Sprite {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		
		
		//------------------------------------
		// public properties
		//------------------------------------
		
		public static const START_TWEEN_SEQUENCE_EVENT:String = "startTweenSequenceEvent";

		//------------------------------------
		// constructor
		//------------------------------------
		
		public function ColorReceiver() {
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
			x = 10;
			y = 10;
			var bt1:PushButton = new PushButton(this, 10, 10, "Parallel Command", chainHandler);
			bt1.width = 170;
			var bt2:PushButton = new PushButton(this, 10, 40, "Async Command", asyncHandler);
			bt2.width = 170;
			var bt3:PushButton = new PushButton(this, 10, 70, "Sequence Command", asyncChainHandler);
			bt3.width = 170;
			var bt4:PushButton = new PushButton(this, 10, 100, "Tween Sequence Command", tweenSequenceHandler);
			bt4.width = 170;
			var bt5:PushButton = new PushButton(this, 10, 130, "Stop All Sequence Commands", stopAllSequencesHandler);
			bt5.width = 170;
		}

		private function chainHandler(e:MouseEvent):void {
			dispatchEvent(new ChainEvent(ChainEvent.CHAIN));
		}
		
		private function asyncHandler(e:MouseEvent):void {
			dispatchEvent(new ASyncEvent(ASyncEvent.CALL));
		}
		
		private function asyncChainHandler(e:MouseEvent):void {
			dispatchEvent(new ASyncEvent(ASyncEvent.CHAIN));
		}
		
		private function stopAllSequencesHandler(e:MouseEvent):void {
			dispatchEvent(new SequenceEvent(SequenceEvent.STOP_ALL_SEQUENCES));
		}

		private function tweenSequenceHandler(e:MouseEvent):void {
			dispatchEvent(new Event(START_TWEEN_SEQUENCE_EVENT));
		}
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		public function dispose():void {
			
		}
		
	}
}
