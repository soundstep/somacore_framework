package com.soma.core.demo.di.views {


	import com.soma.core.mediator.Mediator;
	/**
	 * @author Romuald Quantin
	 */
	public class MyViewMediator extends Mediator {
		
		[Inject]
		public var view:MyView;
		
		public static var count:int = 0; 
		
		public function MyViewMediator() {
			count++;
		}
		
		override protected function initialize():void {
			trace(this, "initialize", count, viewComponent, view, view.id);
		}
		
		override protected function dispose():void {
			trace(this, "dispose");
			view.dispose();
			view = null;
		}
		
	}
}
