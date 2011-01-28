package com.soma.core.demo.di.views {
	import com.soma.core.interfaces.IMediator;
	import com.soma.core.mediator.Mediator;

	import flash.events.IEventDispatcher;

	/**
	 * @author romuald
	 */
	public class EventDispatcherMediator extends Mediator implements IMediator {
		
		[Inject]
		public var dispatcher:IEventDispatcher;
		
		override public function initialize():void {
			trace(">>", this, dispatcher);
		}
		
	}
}
