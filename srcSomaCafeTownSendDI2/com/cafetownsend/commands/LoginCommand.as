package com.cafetownsend.commands {
	import com.cafetownsend.delegates.LoginDelegate;
	import com.cafetownsend.events.EmployeeEvent;
	import com.cafetownsend.events.LoginEvent;
	import com.cafetownsend.events.NavigationEvent;
	import com.cafetownsend.utils.NavigationConstants;
	import com.soma.core.controller.Command;
	import com.soma.core.interfaces.ICommand;
	import com.soma.core.interfaces.IResponder;

	import flash.events.Event;
	
	public class LoginCommand extends Command implements ICommand, IResponder {
		
		[Inject]
		public var loginEvent:LoginEvent;
		
		public function LoginCommand() {
			super();
		}
		
		public function execute(event:Event):void {
			switch (event.type) {
				case LoginEvent.LOGIN:
					// login attempt
					if (loginEvent.loginVO == null) return;
					new LoginDelegate(this, loginEvent.loginVO).call();
					dispatchEvent(new LoginEvent(LoginEvent.MESSAGE, null, loginEvent.info));
					break;
				case LoginEvent.LOGOUT:
					// logout
					dispatchEvent(new LoginEvent(LoginEvent.MESSAGE, null, ""));
					dispatchEvent(new NavigationEvent(NavigationEvent.SELECT, NavigationConstants.LOGIN));
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