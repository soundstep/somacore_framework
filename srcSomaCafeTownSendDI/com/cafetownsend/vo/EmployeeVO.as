package com.cafetownsend.vo {
	
	[Bindable]
	public class EmployeeVO {
		
		public var id:String;
		public var firstname:String;
		public var age:String;
		
		public function EmployeeVO(id:String = null, firstname:String = "", age:String = "") {
			this.id = id;
			this.firstname = firstname;
			this.age = age;
		}
		
		public function toString():String {
			return "[EmployeeVO] " + " id: " + id + ", firstname: " + firstname + ", age: " + age;
		}

	}
}
