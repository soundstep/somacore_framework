package com.cafetownsend.commands
{
	import com.soma.core.controller.Command;
	import com.soma.core.interfaces.ICommand;
	import com.soma.core.interfaces.IResponder;
	import com.cafetownsend.delegates.LoginDelegate;
	import com.cafetownsend.events.EmployeeEvent;
	import com.cafetownsend.events.LoginEvent;
	import com.cafetownsend.events.NavigationEvent;
	import com.cafetownsend.utils.NavigationConstants;
	import com.cafetownsend.wires.LoginWire;
	
	import flash.events.Event;
	
	public class LoginCommand extends Command implements ICommand, IResponder {
		
		public function LoginCommand() {
			super();
		}
		
		public function execute(event:Event):void {
			var loginWire:LoginWire = getWire(LoginWire.NAME) as LoginWire;
			switch (event.type) {
				case LoginEvent.LOGIN:
					// login attempt
					if (LoginEvent(event).loginVO == null) return;
					var delegate:LoginDelegate = new LoginDelegate(this, LoginEvent(event).loginVO);
					delegate.call();
					dispatchEvent(new LoginEvent(LoginEvent.MESSAGE, null, LoginEvent(event).info));
					break;
				case LoginEvent.LOGOUT:
					// logout
					loginWire.showMessage("");
					dispatchEvent(new NavigationEvent(NavigationEvent.SELECT, NavigationConstants.LOGIN));
					break;
				case LoginEvent.MESSAGE:
					// print login message
					loginWire.showMessage(LoginEvent(event).info);
					break;
				case LoginEvent.ERROR:
					// print login error message
					loginWire.showMessage(LoginEvent(event).info);
					break;
				case LoginEvent.SUCCESS:
					// login attempt successful
					dispatchEvent(new EmployeeEvent(EmployeeEvent.GET_ALL));
					dispatchEvent(new NavigationEvent(NavigationEvent.SELECT, NavigationConstants.EMPLOYEE_LIST));
					break;
			}
		}
		
		public function fault(info:Object):void {
			dispatchEvent(new LoginEvent(LoginEvent.ERROR, null, "Login Error, try again."));
		}
		
		public function result(data:Object):void {
			dispatchEvent(new LoginEvent(LoginEvent.SUCCESS, null, "Success"));
		}
		
	}
}