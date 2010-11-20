package com.cafetownsend.events {
	import com.cafetownsend.vo.EmployeeVO;
	
	import flash.events.Event;

	public class EmployeeEvent extends Event {

		public static const GET_ALL:String = "EmployeeEvent.GET_ALL";
		public static const SELECT:String = "EmployeeEvent.SELECT";
		public static const DELETE:String = "EmployeeEvent.DELETE";
		public static const CREATE:String = "EmployeeEvent.CREATE";
		public static const EDIT:String = "EmployeeEvent.EDIT";
		
		public var employee:EmployeeVO;
		
		public function EmployeeEvent(type:String, employee:EmployeeVO = null, bubbles:Boolean = true, cancelable:Boolean = false) {
			this.employee = employee;
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event {
			return new EmployeeEvent(type, employee, bubbles, cancelable);
		}
		
		override public function toString():String {
			return formatToString("EmployeeEvent", "employee", "type", "bubbles", "cancelable", "eventPhase");
		}
		
	}
}
