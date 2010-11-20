package com.cafetownsend.wires {
	import com.cafetownsend.commands.LoginCommand;
	import com.cafetownsend.events.LoginEvent;
	import com.cafetownsend.views.LoginView;
	import com.soma.core.interfaces.IWire;
	import com.soma.core.wire.Wire;

	public class LoginWire extends Wire implements IWire {
		
		public static const NAME:String = "Soma::LoginWire";
		public static const NAME_VIEW_LOGIN:String = "Soma::LoginView";
		
		public function LoginWire() {
			super(NAME);
		}
		
		override public function initialize():void {
			// commands
			addCommand(LoginEvent.LOGIN, LoginCommand);
			addCommand(LoginEvent.LOGOUT, LoginCommand);
			addCommand(LoginEvent.MESSAGE, LoginCommand);
			addCommand(LoginEvent.ERROR, LoginCommand);
			addCommand(LoginEvent.SUCCESS, LoginCommand);
		}
		
		public function showMessage(value:String):void {
			view.message = value;
		}
		
		public function clearMessage():void {
			view.message = "";
		}
		
		public function get view():LoginView {
			return getView(NAME_VIEW_LOGIN) as LoginView; 
		}
		
	}
}