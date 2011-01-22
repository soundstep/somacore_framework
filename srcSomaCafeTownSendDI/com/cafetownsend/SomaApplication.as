package com.cafetownsend {

	import com.soma.debugger.vo.SomaDebuggerVO;
	import com.soma.debugger.SomaDebugger;
	import com.soma.core.di.SomaInjector;
	import flash.events.Event;
	import com.cafetownsend.commands.EmployeeCommand;
	import com.cafetownsend.commands.LoginCommand;
	import com.cafetownsend.commands.NavigationCommand;
	import com.cafetownsend.events.EmployeeEvent;
	import com.cafetownsend.events.LoginEvent;
	import com.cafetownsend.events.NavigationEvent;
	import com.cafetownsend.models.EmployeeModel;
	import com.cafetownsend.views.MainView;
	import com.cafetownsend.views.components.EmployeeDetails;
	import com.cafetownsend.views.components.EmployeeList;
	import com.cafetownsend.views.components.LoginView;
	import com.cafetownsend.views.mediators.EmployeeDetailsMediator;
	import com.cafetownsend.views.mediators.EmployeeListMediator;
	import com.cafetownsend.views.mediators.LoginViewMediator;
	import com.soma.core.Soma;
	import com.soma.core.interfaces.ISoma;

	import mx.core.IVisualElement;

	/**
	 * @author romuald
	 */
	public class SomaApplication extends Soma implements ISoma {
		
		private var _container:SomaCafeTownSend;

		private function added(event:Event):void {
			// initialize application (stage needed)
			setup(_container.stage, SomaInjector);
		}
		
		override protected function initialize():void {
			// map the Main View and the model to instantiated only once
			injector.mapSingleton(MainView);
			injector.mapSingleton(EmployeeModel);
			// map views to mediators
			mediators.mapView(LoginView, LoginViewMediator);
			mediators.mapView(EmployeeList, EmployeeListMediator);			mediators.mapView(EmployeeDetails, EmployeeDetailsMediator);
		}
		
		override protected function registerCommands():void {
			// login
			addCommand(LoginEvent.LOGIN, LoginCommand);
			addCommand(LoginEvent.LOGOUT, LoginCommand);
			addCommand(LoginEvent.SUCCESS, LoginCommand);
			addCommand(LoginEvent.ERROR, LoginCommand);
			addCommand(LoginEvent.MESSAGE, LoginCommand);
			// navigation
			addCommand(NavigationEvent.SELECT, NavigationCommand);
			// command
			addCommand(EmployeeEvent.SELECT, EmployeeCommand);
			addCommand(EmployeeEvent.DELETE, EmployeeCommand);
			addCommand(EmployeeEvent.CREATE, EmployeeCommand);
			addCommand(EmployeeEvent.EDIT, EmployeeCommand);			addCommand(EmployeeEvent.UPDATED, EmployeeCommand);
		}
		
		override protected function registerViews():void {
			// add Main View (ViewStack) to the display list
			_container.addElement(IVisualElement(injector.getInstance(MainView)));
		}
		
		override protected function registerPlugins():void {
			// create Soma Debugger
			createPlugin(SomaDebugger, new SomaDebuggerVO(this, SomaDebugger.NAME_DEFAULT, getCommands(), true, false));
		}
		
		public function set container(value:SomaCafeTownSend):void {
			// register container, listen to the added to stage event
			_container = value;
			_container.addEventListener(Event.ADDED_TO_STAGE, added);
		}

	}
}
