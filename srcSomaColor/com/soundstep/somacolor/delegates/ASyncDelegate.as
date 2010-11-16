package com.soundstep.somacolor.delegates {
	import com.soma.core.interfaces.IResponder;

	import flash.events.TimerEvent;
	import flash.utils.Timer;

	/**
	 * <b>Author:</b> Romuald Quantin - <a href="http://www.soundstep.com/" target="_blank">www.soundstep.com</a><br />* <b>Class version:</b> 1.0<br />
	 * <b>Actionscript version:</b> 3.0<br />
	 * <b>Copyright:</b> 
	 * <br />
	 * <b>Date:</b> Sep 22, 2009<br />
	 * <b>Usage:</b>
	 * @example
	 * <listing version="3.0"></listing>
	 */
	
	public class ASyncDelegate {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		private var _responder:IResponder;
		
		private var _timer:Timer;

		//------------------------------------
		// public properties
		//------------------------------------
		
		
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		public function ASyncDelegate(responder:IResponder) {
			_responder = responder;
		}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		private function timerComplete(e:TimerEvent):void {
			_timer.removeEventListener(TimerEvent.TIMER_COMPLETE, timerComplete);
			_timer.stop();
			_timer = null;
			var result:Number = Math.floor(Math.random() * 6);
			if (result > 0) {
				_responder.result({id:"myData", data:"I'm a success"});
			}
			else {
				_responder.fault({id:"myData", data:"I'm a fault"});
			}
		}
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		public function call():void {
			_timer = new Timer(500);
			_timer.addEventListener(TimerEvent.TIMER, timerComplete);
			_timer.start();
		}
		
	}
}