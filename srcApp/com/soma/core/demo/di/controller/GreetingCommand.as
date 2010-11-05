package com.soma.core.demo.di.controller {

	import com.soma.core.demo.di.wires.GreetingWire2;
	import com.soma.core.demo.di.wires.GreetingWire;
	import com.soma.core.demo.di.models.SimpleModel;
	import flash.events.Event;
	import com.soma.core.controller.Command;
	import com.soma.core.interfaces.ICommand;

	/**
	 * @author Romuald Quantin
	 */
	public class GreetingCommand extends Command implements ICommand {
		
		[Inject]
		public var model:SimpleModel;
		
		[Inject]
		public var wire1:GreetingWire;
		
		[Inject]
		public var wire2:GreetingWire2;
		
		public function execute(event:Event):void {
			trace(this, model, wire1, wire2, wire1.simpleView);
		}
		
	}
}
