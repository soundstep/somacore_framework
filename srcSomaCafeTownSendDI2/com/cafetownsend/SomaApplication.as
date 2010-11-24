package com.cafetownsend {

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
	import com.soma.core.di.SomaInjector;
	import com.soma.core.interfaces.ISoma;

	import mx.core.IVisualElement;

	/**
	 * @author romuald
	 */
	public class SomaApplication extends Soma implements ISoma {
		
		private var _container:SomaCafeTownSend;

		public function SomaApplication(container:SomaCafeTownSend) {
			_container = container;
			super(_container.stage, SomaInjector);
		}
		
		override protected function initialize():void {
			injector.mapSingleton(MainView);
			injector.mapSingleton(EmployeeModel);
			mediators.mapView(LoginView, LoginViewMediator);
			mediators.mapView(EmployeeList, EmployeeListMediator);			mediators.mapView(EmployeeDetails, EmployeeDetailsMediator);
		}
		
		override protected function registerCommands():void {
			addCommand(LoginEvent.LOGIN, LoginCommand);
			addCommand(LoginEvent.LOGOUT, LoginCommand);
			addCommand(LoginEvent.SUCCESS, LoginCommand);
			addCommand(NavigationEvent.SELECT, NavigationCommand);
			addCommand(EmployeeEvent.SELECT, EmployeeCommand);
			addCommand(EmployeeEvent.DELETE, EmployeeCommand);
			addCommand(EmployeeEvent.CREATE, EmployeeCommand);
			addCommand(EmployeeEvent.EDIT, EmployeeCommand);
		}
		
		override protected function registerViews():void {
			_container.addElement(IVisualElement(injector.createInstance(MainView)));
		}
		
		override protected function start():void {
			
		}

		public function get container():SomaCafeTownSend {
			return _container;
		}
		
		public function get mainView():MainView {
			return getView("main") as MainView;
		}
		
	}
}
