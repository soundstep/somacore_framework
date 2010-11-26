package com.soma.core.tests.suites.support {

	import com.soma.core.interfaces.IMediator;
	import com.soma.core.mediator.Mediator;

	import flash.events.Event;

	/**
	 * @author Romuald Quantin (romu@soundstep.com)
	 */
	public class EmptyViewMediator extends Mediator implements IMediator {

		[Inject]
		public var view:EmptyView;

		public static const EVENT_INITIALIZED:String = "EmptyMediator::Event.EVENT_INITIALIZED";
		public static const EVENT_DISPOSED:String = "EmptyMediator::Event.EVENT_DISPOSED";
		
		override public function initialize():void {
			dispatchEvent(new Event(EVENT_INITIALIZED));
		}
		
		override public function dispose():void {
			dispatchEvent(new Event(EVENT_DISPOSED));
		}
		
	}
}
