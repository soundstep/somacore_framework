package com.cafetownsend.delegates {
	import com.soma.core.interfaces.IResponder;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	public class EmployeeDelegate {

		private var _responder:IResponder;

		public function EmployeeDelegate(responder:IResponder) {
			_responder = responder;
		}
		
		private function complete():void {
			// simulation of a remoting result
			var data:XML = <employees>
				<employee id="1">
					<name><![CDATA[John]]></name>
					<age><![CDATA[32]]></age>
				</employee>
				<employee id="2">
					<name><![CDATA[Dave]]></name>
					<age><![CDATA[21]]></age>
				</employee>
				<employee id="3">
					<name><![CDATA[Sue]]></name>
					<age><![CDATA[46]]></age>
				</employee>
			</employees>;
			_responder.result(data);
		}
		
		public function call():void {
			// simulation of a remoting call
			complete();
		}
		
	}
}