package com.soma.core.demo.twittersearch {
	import com.soma.core.demo.twittersearch.views.MainView;
	import com.soma.core.Soma;
	import com.soma.core.demo.twittersearch.controller.commands.SearchCommand;
	import com.soma.core.demo.twittersearch.controller.events.TwitterEvent;
	import com.soma.core.demo.twittersearch.services.TwitterService;
	import com.soma.core.demo.twittersearch.wires.SearchWire;
	import com.soma.core.di.SomaInjector;
	import com.soma.core.interfaces.ISoma;

	import flash.display.StageAlign;
	import flash.display.StageScaleMode;

	/**
	 * @author romuald
	 */
	public class SomaApplication extends Soma implements ISoma {
		
		private var _container:Main;

		public function SomaApplication(container:Main) {
			_container = container;
			super(_container.stage, SomaInjector);
		}

		override protected function initialize():void {
			// stage
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			// injector
			injector.map(MainView, MainView);
			injector.mapSingleton(TwitterService);
			injector.mapSingleton(SearchWire);
			injector.createInstance(SearchWire);		}
		
		override protected function registerCommands():void {
			addCommand(TwitterEvent.SEARCH, SearchCommand);
		}
		
	}
}
