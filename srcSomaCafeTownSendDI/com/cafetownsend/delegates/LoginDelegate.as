package com.cafetownsend.delegates {
	import com.soma.core.interfaces.IResponder;
	import com.cafetownsend.vo.LoginVO;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	public class LoginDelegate {

		private var _responder:IResponder;
		private var _vo:LoginVO;
		private var _timer:Timer;

		public function LoginDelegate(responder:IResponder, loginVO:LoginVO) {
			_responder = responder;
			_vo = loginVO;
		}
		
		private function timerComplete(e:TimerEvent):void {
			// simulation of a remoting result
			_timer.removeEventListener(TimerEvent.TIMER_COMPLETE, timerComplete);
			_timer.stop();
			_timer = null;
			if (_vo.username == "flex" && _vo.password == "soma") {
				_responder.result({id:"LoginAttempt " + new Date().getTime(), result:"success"});
			}
			else {
				_responder.fault({id:"LoginAttempt " + new Date().getTime(), result:"error"});
			}
		}
		
		public function call():void {
			// simulation of a remoting call
			_timer = new Timer(500);
			_timer.addEventListener(TimerEvent.TIMER, timerComplete);
			_timer.start();
		}
		
	}
}