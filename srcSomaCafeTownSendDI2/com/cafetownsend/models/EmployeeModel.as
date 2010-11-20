package com.cafetownsend.models
{
	import com.soma.core.interfaces.IModel;
	import com.soma.core.model.Model;

	public class EmployeeModel extends Model implements IModel {
		
		public static const NAME:String = "Soma::EmployeeModel";
		
		public function EmployeeModel() {
			super(NAME);
		}
		
		override public function initialize():void {
			
		}
		
	}
}