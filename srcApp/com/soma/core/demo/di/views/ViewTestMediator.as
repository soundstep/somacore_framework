package com.soma.core.demo.di.views {
	import com.soma.core.interfaces.IMediator;
	import com.soma.core.mediator.Mediator;

	/**
	 * @author romuald
	 */
	public class ViewTestMediator extends Mediator implements IMediator {
		
		[Inject]
		public var view:IViewTest;
		
		override public function initialize():void {
			trace(">>", this, view);
		}
	}
}
