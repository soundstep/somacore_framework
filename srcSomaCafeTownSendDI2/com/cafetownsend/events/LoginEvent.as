package com.cafetownsend.events {
	import com.cafetownsend.vo.LoginVO;
	
	import flash.events.Event;

	public class LoginEvent extends Event {

		public static const LOGIN:String = "LoginEvent.LOGIN";
		public static const LOGOUT:String = "LoginEvent.LOGOUT";
		public static const MESSAGE:String = "LoginEvent.MESSAGE";
		public static const ERROR:String = "LoginEvent.ERROR";
		public static const SUCCESS:String = "LoginEvent.SUCCESS";
		
		public var loginVO:LoginVO;
		public var info:String;
		
		public function LoginEvent(type:String, loginVO:LoginVO = null, info:String = "", bubbles:Boolean = true, cancelable:Boolean = false) {
			this.loginVO = loginVO;
			this.info = info;
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event {
			return new LoginEvent(type, loginVO, info, bubbles, cancelable);
		}
		
		override public function toString():String {
			return formatToString("LoginEvent", "loginVO", "info", "type", "bubbles", "cancelable", "eventPhase");
		}
		
	}
}
