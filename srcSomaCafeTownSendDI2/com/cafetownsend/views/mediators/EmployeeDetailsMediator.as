package com.cafetownsend.views.mediators {

	import com.cafetownsend.views.components.EmployeeDetails;
	import com.cafetownsend.events.EmployeeEvent;
	import com.soma.core.interfaces.IMediator;
	import com.soma.core.mediator.Mediator;

	/**
	 * @author Romuald Quantin (romu@soundstep.com)
	 */
	public class EmployeeDetailsMediator extends Mediator implements IMediator {
		
		[Inject]
		public var view:EmployeeDetails;
		
		override public function initialize():void {
			addEventListener(EmployeeEvent.SELECT, employeeSelectedhandler);
		}

		private function employeeSelectedhandler(event:EmployeeEvent):void {
			view.selectedEmployee = event.employee;
		}
		
	}
}
