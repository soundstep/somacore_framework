package com.soma.core.demo.helloworld {
	import com.soma.core.Soma;
	import com.soma.core.demo.helloworld.controller.commands.MessageCommand;
	import com.soma.core.demo.helloworld.controller.events.MessageEvent;
	import com.soma.core.demo.helloworld.mediators.MessageViewMediator;
	import com.soma.core.demo.helloworld.models.MessageModel;
	import com.soma.core.demo.helloworld.views.MessageView;
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
			initialize();
		}

		private function initialize():void {
			stage.align = StageAlign.TOP_LEFT;			stage.scaleMode = StageScaleMode.NO_SCALE;
		}

		override protected function registerCommands():void {
			addCommand(MessageEvent.REQUEST, MessageCommand);
		}
		
		override protected function registerModels():void {
			injector.mapSingleton(MessageModel);
		}
		
		override protected function registerViews():void {
			mediators.mapView(MessageView, MessageViewMediator);
			_container.addChild(new MessageView());
		}
		
		public function get container():Main {
			return _container;
		}
		
	}
}
