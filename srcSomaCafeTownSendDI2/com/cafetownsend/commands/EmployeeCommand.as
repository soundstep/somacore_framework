package com.cafetownsend.commands {

	import com.cafetownsend.models.EmployeeModel;
	import com.cafetownsend.events.EmployeeEvent;
	import com.cafetownsend.vo.EmployeeVO;
	import com.soma.core.controller.Command;
	import com.soma.core.interfaces.ICommand;

	import flash.events.Event;

	public class EmployeeCommand extends Command implements ICommand {
		
		[Inject]
		public var model:EmployeeModel;
		
		public function EmployeeCommand() {
			
		}
		
		public function execute(event:Event):void {
//			var wire:EmployeeWire = getWire(EmployeeWire.NAME) as EmployeeWire;
			var vo:EmployeeVO = EmployeeEvent(event).employee;
			switch (event.type) {
//				case EmployeeEvent.SELECT:
//					wire.selectedEmployee = vo;
//					break;
//				case EmployeeEvent.DELETE:
//					wire.deleteEmployee(vo);
//					break;
				case EmployeeEvent.CREATE:
					var data:XML = model.data as XML;
					var employee:XML = <employee/>;
					employee.@id = new Date().getTime();
					employee.firstname = vo.firstname;
					employee.age = vo.age;
					data.appendChild(employee);
//					model.setData(data);
//					wire.createEmployee(vo);
					break;
//				case EmployeeEvent.EDIT:
//					wire.editEmployee(vo);
//					break;
			}
		}
		
	}
}