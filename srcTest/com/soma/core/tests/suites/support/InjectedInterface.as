package com.soma.core.tests.suites.support {
	import flash.display.Sprite;
	
	/**
	 * <b>Author:</b> Romuald Quantin - <a href="http://www.soundstep.com/" target="_blank">www.soundstep.com</a><br />
	 * <b>Class version:</b> 1.0<br />
	 * <b>Actionscript version:</b> 3.0<br />
	 * <b>Date:</b> Oct 9, 2010<br />
	 * @example
	 * <listing version="3.0"></listing>
	 */
	
	public class InjectedInterface extends Sprite implements IEmptyView {

		[Inject]
		public var injected:IEmptyView;
		
	}
}