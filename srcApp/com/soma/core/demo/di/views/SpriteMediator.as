package com.soma.core.demo.di.views {
	import com.soma.core.interfaces.IMediator;
	import com.soma.core.mediator.Mediator;

	import flash.display.Sprite;

	/**
	 * @author romuald
	 */
	public class SpriteMediator extends Mediator implements IMediator {
		
		[Inject]
		public var mySprite:Sprite;
		
		override public function initialize():void {
			trace(">>", this, mySprite);
		}
		
	}
}
