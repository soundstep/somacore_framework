package com.cafetownsend.vo {
	
	[Bindable]
	public class EmployeeVO {
		
		public var id:String;
		public var name:String;
		public var age:String;
		
		public function EmployeeVO(id:String = null, name:String = "", age:String = "") {
			this.id = id;
			this.name = name;
			this.age = age;
		}
		
		public function toString():String {
			return "[EmployeeVO] " + " id: " + id + ", name: " + name + ", age: " + age;
		}

	}
}
