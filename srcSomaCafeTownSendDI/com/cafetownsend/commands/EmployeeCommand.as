package com.cafetownsend.commands {

	import com.cafetownsend.events.EmployeeEvent;
	import com.cafetownsend.models.EmployeeModel;
	import com.cafetownsend.vo.EmployeeVO;
	import com.soma.core.controller.Command;
	import com.soma.core.interfaces.ICommand;

	import flash.events.Event;

	public class EmployeeCommand extends Command implements ICommand {
		
		[Inject]
		public var model:EmployeeModel;
		
		public function execute(event:Event):void {
			var vo:EmployeeVO = EmployeeEvent(event).employee;
			switch (event.type) {
				case EmployeeEvent.DELETE:
					model.deleteEmployee(vo);
					break;
				case EmployeeEvent.CREATE:
					model.addEmployee(vo);
					break;
				case EmployeeEvent.EDIT:
					model.editEmployee(vo);
					break;
			}
		}
		
	}
}