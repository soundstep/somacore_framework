package com.soma.core.demo.di {
	import flash.display.Sprite;

	/**
	 * @author Romuald Quantin
	 */
	public class Main extends Sprite {

		private var _app:SomaApplication;
		
		public function Main() {
			_app = new SomaApplication(this);
		}
		
	}
}
