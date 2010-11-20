package com.cafetownsend {
	
	import com.cafetownsend.commands.NavigationCommand;
	import com.cafetownsend.commands.StartCommand;
	import com.cafetownsend.events.NavigationEvent;
	import com.cafetownsend.events.StartEvent;
	import com.cafetownsend.wires.EmployeeWire;
	import com.cafetownsend.wires.LoginWire;
	import com.soma.core.Soma;
	import com.soma.debugger.SomaDebugger;
	import com.soma.debugger.vo.SomaDebuggerVO;
	import com.soma.core.interfaces.ISoma;

	public class SomaApplication extends Soma implements ISoma {
		
		private var _app:SomaCafeTownSend;
		
		public function SomaApplication(app:SomaCafeTownSend) {
			_app = app;
			super(app.stage);
			dispatchEvent(new StartEvent(StartEvent.START));
		}
		
		override protected function registerCommands():void {
			addCommand(StartEvent.START, StartCommand);
			addCommand(NavigationEvent.SELECT, NavigationCommand);
		}
		
		override protected function registerViews():void {
			addView(LoginWire.NAME_VIEW_LOGIN, app.loginView);
			addView(EmployeeWire.NAME_VIEW_EMPLOYEE_LIST, app.employeList);
			addView(EmployeeWire.NAME_VIEW_EMPLOYEE_DETAILS, app.employeDetails);
		}
		
		override protected function registerWires():void {
			addWire(LoginWire.NAME, new LoginWire());
			addWire(EmployeeWire.NAME, new EmployeeWire());
		}
		
		override protected function registerPlugins():void {
			// debugger plugin
			createPlugin(SomaDebugger, new SomaDebuggerVO(this, SomaDebugger.NAME_DEFAULT, getCommands(), true, false));
		}
		
		public function get app():SomaCafeTownSend {
			return _app;
		}
		
	}
}