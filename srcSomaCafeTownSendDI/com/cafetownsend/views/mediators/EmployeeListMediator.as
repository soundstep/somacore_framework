package com.cafetownsend.views.mediators {

	import com.cafetownsend.events.EmployeeEvent;
	import com.cafetownsend.models.EmployeeModel;
	import com.cafetownsend.views.components.EmployeeList;
	import com.soma.core.interfaces.IMediator;
	import com.soma.core.mediator.Mediator;

	import mx.collections.XMLListCollection;

	/**
	 * @author Romuald Quantin (romu@soundstep.com)
	 */
	public class EmployeeListMediator extends Mediator implements IMediator {

		[Inject]
		public var model:EmployeeModel;

		[Inject]
		public var view:EmployeeList;

		override public function initialize():void {
			setDataToView();
			addEventListener(EmployeeEvent.UPDATED, updateHandler);
		}
		
		private function setDataToView():void {
			view.employeeListData = new XMLListCollection(model.data.children());
		}

		private function updateHandler(event:EmployeeEvent):void {
			setDataToView();
		}

	}
}
