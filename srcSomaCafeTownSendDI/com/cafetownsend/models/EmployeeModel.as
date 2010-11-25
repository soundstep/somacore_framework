package com.cafetownsend.models {

	import com.cafetownsend.events.EmployeeEvent;
	import com.cafetownsend.vo.EmployeeVO;
	import com.soma.core.interfaces.IModel;
	import com.soma.core.model.Model;

	public class EmployeeModel extends Model implements IModel {
		
		public static const NAME:String = "Soma::EmployeeModel";
		
		public function EmployeeModel() {
			super(NAME);
		}
		
		override public function initialize():void {
			data = <employees>
				<employee id="1">
					<firstname><![CDATA[John]]></firstname>
					<age><![CDATA[32]]></age>
				</employee>
				<employee id="2">
					<firstname><![CDATA[Dave]]></firstname>
					<age><![CDATA[21]]></age>
				</employee>
				<employee id="3">
					<firstname><![CDATA[Sue]]></firstname>
					<age><![CDATA[46]]></age>
				</employee>
			</employees>;
			dispatchUpdate();
		}
		
		private function dispatchUpdate():void {
			dispatchEvent(new EmployeeEvent(EmployeeEvent.UPDATED));
		}

		public function addEmployee(vo:EmployeeVO):void {
			var data:XML = data as XML;
			var employee:XML = <employee/>;
			employee.@id = new Date().getTime();
			employee.firstname = vo.firstname;
			employee.age = vo.age;
			data.appendChild(employee);
			dispatchUpdate();
		}

		public function editEmployee(vo:EmployeeVO):void {
			var data:XML = data as XML;
			var employee:XML = data.children().(@id == vo.id)[0];
			if (employee != null) {
				employee.firstname = vo.firstname;
				employee.age = vo.age;
			}
			dispatchUpdate();
		}

		public function deleteEmployee(vo:EmployeeVO):void {
			var data:XML = data as XML;
			var employee:XML = data.children().(@id == vo.id)[0];
			if (employee != null) {
				delete data.children()[employee.childIndex()];
			}
			dispatchUpdate();
		}
		
	}
}
