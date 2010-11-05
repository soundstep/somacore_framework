package com.soma.core.mediator {

	import com.soma.core.interfaces.IMediator;
	import com.soma.core.ns.somans;
	import com.soma.core.wire.Wire;

	/**
	 * @author Romuald Quantin
	 */
	public class Mediator extends Wire implements IMediator {
		
		public var viewComponent:Object;
		
		public function Mediator(name:String = null) {
			super(name);
		}
		
		somans function registerViewComponent(viewComponent:Object):void {
			this.viewComponent = viewComponent;
		}
		
	}
}
