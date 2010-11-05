package com.soma.core.demo.di {

	import com.soma.core.di.SomaInjector;
	import com.soma.core.Soma;
	import com.soma.core.demo.di.views.MyView;
	import com.soma.core.demo.di.views.MyViewMediator;
	import com.soma.core.interfaces.ISoma;

	/**
	 * @author Romuald Quantin
	 */
	public class SomaApplication extends Soma implements ISoma {

		private var _container:Main;

		public function SomaApplication(container:Main) {
			_container = container;
			super(_container.stage, SomaInjector);
			
//			dispatchEvent(new Event('commandTest', true));
			
		}

		override protected function registerCommands():void {
//			addCommand('commandTest', GreetingCommand);
		}
		
		override protected function registerWires():void {
			
			// small tests in progress before writing correct unit tests
			
			// test 1
//			injector.mapSingleton(SimpleModel);//			injector.mapSingleton(GreetingWire2);
//			injector.mapSingleton(SimpleView);
//			injector.createInstance(GreetingWire);
			// test 2
//			injector.mapSingleton(SimpleModel);
//			injector.mapSingleton(GreetingWire2);
//			injector.createInstance(GreetingWire);
//			injector.createInstance(GreetingWire);
			// test 3
//			injector.mapSingleton(SimpleModel);
//			injector.mapSingleton(GreetingWire2);
//			var view:SimpleView = new SimpleView();
//			injector.mapToInstance(SimpleView, view);
//			injector.createInstance(GreetingWire);//			injector.createInstance(GreetingWire);
			// test 4 (simple injection)
//			injector.createInstance(Car);
			// test 5 (constructor injection with interface mapping)
//			injector.mapTo(IEngine, LittleEngine);
//			injector.createInstance(Car2);
			// test 6 (constructor and setter with named injections)
//			injector.mapTo(IEngine, LittleEngine);
//			injector.mapTo(IInterior, BasicInterior);
//			injector.createInstance(Car3);
//			injector.mapTo(IInterior, SportyInterior, "sport");
//			injector.createInstance(CarSport);
//			injector.mapTo(IInterior, HybridInterior, "hybrid");
//			injector.createInstance(CarHybrid);
			// test 7 (inject value)
//			injector.mapToInstance(String, "http://soundstep.com");
//			injector.createInstance(TestInjection);
			// test 8 (inject named value)
//			injector.mapToInstance(String, "http://soundstep.com", "url");
//			injector.createInstance(TestNamedInjection);
			// test 9 (factory) ----------------------> DOES NOT WORK
//			injector.mapTo(IEngine, LittleEngine);
//			injector.mapToInstance(String, "EN", "country code");
//			injector.mapToFactory(GpsSystem, GpsFactory);
//			injector.createInstance(Car4);
			// test 10 (singleton)
//			injector.mapSingleton(SimpleModel);
//			injector.mapSingleton(GreetingWire2);
//			injector.mapSingleton(SimpleView);
//			injector.createInstance(GreetingWire);
//			injector.createInstance(GreetingWire);
//			injector.createInstance(GreetingWire);
//			injector.createInstance(GreetingWire);
			// test 11 (eager singleton)
//			injector.mapSingleton(SimpleModel, true);
//			injector.mapSingleton(GreetingWire2, true);
//			injector.mapSingleton(SimpleView, true);
//			injector.createInstance(GreetingWire);
//			injector.createInstance(GreetingWire);
//			injector.createInstance(GreetingWire);
//			injector.createInstance(GreetingWire);
			// test 12 (double singleton mapping) ----------------------> is a bug?
//			injector.mapSingleton(GreetingWire2);
//			injector.mapSingleton(SimpleView);
//			injector.mapSingleton(SimpleModel);
//			injector.createInstance(GreetingWire);
//			injector.mapSingleton(SimpleModel);
//			injector.createInstance(GreetingWire); // should not create a second SimpleModel instance
			// test 13 (child injector) ----------------------> TO TEST
//			var child:ISomaInjector = injector.createChildInjector();
			// test 14 (mediator)
			mediators.mapView(MyView, MyViewMediator);
			var view:MyView = new MyView();
			_container.addChild(view);			_container.removeChild(view);
			view = new MyView();
			_container.addChild(view);
			_container.removeChild(view);
		}

		public function get container():Main {
			return _container;
		}

	}
}
