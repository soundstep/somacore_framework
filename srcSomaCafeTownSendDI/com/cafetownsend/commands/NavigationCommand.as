package com.cafetownsend.commands {

	import com.cafetownsend.events.NavigationEvent;
	import com.cafetownsend.views.MainView;
	import com.soma.core.controller.Command;
	import com.soma.core.interfaces.ICommand;

	import flash.events.Event;
	

	public class NavigationCommand extends Command implements ICommand {
		
		[Inject]
		public var view:MainView;
		
		public function execute(event:Event):void {
			view.selectedIndex = NavigationEvent(event).navigationID;
		}
		
	}
}
