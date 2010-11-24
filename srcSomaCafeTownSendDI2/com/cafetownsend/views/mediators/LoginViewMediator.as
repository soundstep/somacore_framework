package com.cafetownsend.views.mediators {
	import com.cafetownsend.events.LoginEvent;
	import com.cafetownsend.views.components.LoginView;
	import com.soma.core.interfaces.IMediator;
	import com.soma.core.mediator.Mediator;

	/**
	 * @author romuald
	 */
	public class LoginViewMediator extends Mediator implements IMediator {
		
		[Inject]
		public var view:LoginView;
		
		override public function initialize():void {
			addEventListener(LoginEvent.MESSAGE, messageHandler, false, 0, true);
			addEventListener(LoginEvent.ERROR, messageHandler, false, 0, true);
		}

		private function messageHandler(event:LoginEvent):void {
			view.message = event.info;
		}
		
	}
}
