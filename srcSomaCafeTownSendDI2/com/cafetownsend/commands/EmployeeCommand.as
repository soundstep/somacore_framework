package com.cafetownsend.commands {
	import com.soma.core.controller.Command;
	import com.soma.core.interfaces.ICommand;

	import flash.events.Event;

	public class EmployeeCommand extends Command implements ICommand {
		
		public function EmployeeCommand() {
			
		}
		
		public function execute(event:Event):void {
//			var wire:EmployeeWire = getWire(EmployeeWire.NAME) as EmployeeWire;
//			var vo:EmployeeVO = EmployeeEvent(event).employee;
//			switch (event.type) {
//				case EmployeeEvent.SELECT:
//					wire.selectedEmployee = vo;
//					break;
//				case EmployeeEvent.DELETE:
//					wire.deleteEmployee(vo);
//					break;
//				case EmployeeEvent.CREATE:
//					wire.createEmployee(vo);
//					break;
//				case EmployeeEvent.EDIT:
//					wire.editEmployee(vo);
//					break;
//			}
		}
		
	}
}