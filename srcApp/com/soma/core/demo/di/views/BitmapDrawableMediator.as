package com.soma.core.demo.di.views {
	import com.soma.core.interfaces.IMediator;
	import com.soma.core.mediator.Mediator;

	import flash.display.IBitmapDrawable;

	/**
	 * @author romuald
	 */
	public class BitmapDrawableMediator extends Mediator implements IMediator {
		
		[Inject]
		public var drawable:IBitmapDrawable;
		
		override public function initialize():void {
			trace(">>", this, drawable);
		}
		
	}
}
