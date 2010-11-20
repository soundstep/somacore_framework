package com.cafetownsend.commands
{
	import com.cafetownsend.delegates.EmployeeDelegate;
	import com.cafetownsend.models.EmployeeModel;
	import com.cafetownsend.wires.EmployeeWire;
	import com.soma.core.controller.Command;
	import com.soma.core.interfaces.ICommand;
	import com.soma.core.interfaces.IResponder;
	
	import flash.events.Event;
	
	public class EmployeeGetAllCommand extends Command implements ICommand, IResponder {
		
		public function EmployeeGetAllCommand() {
			
		}
		
		public function execute(event:Event):void {
			if (getModel(EmployeeModel.NAME).data != null) return;
			var delegate:EmployeeDelegate = new EmployeeDelegate(this);
			delegate.call();
		}
		
		public function fault(info:Object):void {
			trace("Error in ", this, " ", String(info));
		}
		
		public function result(data:Object):void {
			var wire:EmployeeWire = getWire(EmployeeWire.NAME) as EmployeeWire;
			wire.setData(data as XML);
		}
		
	}
}