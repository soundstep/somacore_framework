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
		}
		
	}
}
