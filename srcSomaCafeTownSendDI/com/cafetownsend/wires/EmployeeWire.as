package com.cafetownsend.wires {
	
	import com.soma.core.interfaces.IWire;
	import com.soma.core.wire.Wire;
	import com.cafetownsend.SomaApplication;
	import com.cafetownsend.commands.EmployeeCommand;
	import com.cafetownsend.commands.EmployeeGetAllCommand;
	import com.cafetownsend.events.EmployeeEvent;
	import com.cafetownsend.events.NavigationEvent;
	import com.cafetownsend.models.EmployeeModel;
	import com.cafetownsend.utils.NavigationConstants;
	import com.cafetownsend.views.EmployeDetails;
	import com.cafetownsend.views.EmployeList;
	import com.cafetownsend.vo.EmployeeVO;
	
	import flash.display.DisplayObjectContainer;
	
	import mx.collections.XMLListCollection;

	public class EmployeeWire extends Wire implements IWire {
		
		private var _selectedEmployee:EmployeeVO;
		
		public static const NAME:String = "Soma::EmployeeWire";
		public static const NAME_VIEW_EMPLOYEE_LIST:String = "Soma::EmployeeList";
		public static const NAME_VIEW_EMPLOYEE_DETAILS:String = "Soma::EmployeeDetails";
		
		public function EmployeeWire() {
			super(NAME);
		}
		
		override public function initialize():void {
			var app:DisplayObjectContainer = SomaApplication(instance).app;
			// models
			addModel(EmployeeModel.NAME, new EmployeeModel());
			// commands
			addCommand(EmployeeEvent.GET_ALL, EmployeeGetAllCommand);
			addCommand(EmployeeEvent.SELECT, EmployeeCommand);
			addCommand(EmployeeEvent.DELETE, EmployeeCommand);
			addCommand(EmployeeEvent.CREATE, EmployeeCommand);
			addCommand(EmployeeEvent.EDIT, EmployeeCommand);
		}
		
		public function setData(value:XML):void {
			model.data = value;
			var collection:XMLListCollection = new XMLListCollection(value.children());
			employeeListView.employeeListData = collection;
		}
		
		public function deleteEmployee(vo:EmployeeVO):void {
			var data:XML = model.data as XML;
			var employee:XML = data.children().(@id == vo.id)[0];
			if (employee != null) {
				delete data.children()[employee.childIndex()];
			}
			setData(data);
		}
		
		public function createEmployee(vo:EmployeeVO):void {
			var data:XML = model.data as XML;
			var employee:XML = <employee/>;
			employee.@id = new Date().getTime();
			employee.name = vo.name;
			employee.age = vo.age;
			data.appendChild(employee);
			setData(data);
		}
		
		public function editEmployee(vo:EmployeeVO):void {
			var data:XML = model.data as XML;
			var employee:XML = data.children().(@id == vo.id)[0];
			if (employee != null) {
				employee.name = vo.name;
				employee.age = vo.age;
			}
			setData(data);
		}
		
		public function get selectedEmployee():EmployeeVO {
			return _selectedEmployee;
		}
		
		public function set selectedEmployee(vo:EmployeeVO):void {
			_selectedEmployee = vo;
			employeeDetailsView.selectedEmployee = vo;
		}
		
		public function get model():EmployeeModel {
			return getModel(EmployeeModel.NAME) as EmployeeModel;
		}
		
		public function get employeeListView():EmployeList {
			return getView(NAME_VIEW_EMPLOYEE_LIST) as EmployeList;
		}
		
		public function get employeeDetailsView():EmployeDetails {
			return getView(NAME_VIEW_EMPLOYEE_DETAILS) as EmployeDetails;
		}
		
	}
}