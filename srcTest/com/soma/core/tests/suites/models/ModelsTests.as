package com.soma.core.tests.suites.models {

	import com.soma.core.Soma;
	import com.soma.core.di.SomaInjector;
	import com.soma.core.interfaces.ISoma;
	import com.soma.core.model.Model;
	import com.soma.core.tests.suites.support.EmptyModel;

	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertNull;
	import org.flexunit.asserts.assertTrue;
	import org.flexunit.asserts.fail;
	import org.flexunit.async.Async;
	import org.hamcrest.assertThat;
	import org.hamcrest.object.instanceOf;

	import mx.core.FlexGlobals;

	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	/**
	 * <b>Author:</b> Romuald Quantin - <a href="http://www.soundstep.com/" target="_blank">www.soundstep.com</a><br />
	 * <b>Class version:</b> 1.0<br />
	 * <b>Actionscript version:</b> 3.0<br />
	 * <b>Date:</b> Oct 6, 2010<br />
	 * @example
	 * <listing version="3.0"></listing>
	 */
	
	public class ModelsTests {
		
		private var _soma:ISoma;		private var _somaInjection:ISoma;
		
		private static var _stage:Stage;
		
		[BeforeClass]
		public static function runBeforeClass():void {
			_stage = FlexGlobals.topLevelApplication.stage;
		}
		
		[AfterClass]
		public static function runAfterClass():void {
			_stage = null;
		} 
		
		[Before]
		public function runBefore():void {
			_soma = new Soma(_stage);
			_somaInjection = new Soma(_stage, SomaInjector);
		}
		
		[After]
		public function runAfter():void {
			_soma.dispose();
			_soma = null;
			_somaInjection.dispose();
			_somaInjection = null;
		}
		
		[Test]
		public function testHasModel():void {
			_soma.addModel(EmptyModel.NAME, new EmptyModel());
			assertTrue(_soma.hasModel(EmptyModel.NAME));
		}
		
		[Test]
		public function testGetModel():void {
			_soma.addModel(EmptyModel.NAME, new EmptyModel());
			assertThat(_soma.getModel(EmptyModel.NAME), instanceOf(EmptyModel));
		}
		
		[Test]
		public function testRemoveModel():void {
			_soma.addModel(EmptyModel.NAME, new EmptyModel());
			_soma.removeModel(EmptyModel.NAME);
			assertNull(_soma.getModel(EmptyModel.NAME));
		}
		
		[Test]
		public function testModelsLength():void {
			_soma.addModel(EmptyModel.NAME, new EmptyModel());
			var count:int = 0;
			for (var model:String in _soma.getModels()) {
				if (model) count++;
			}
			assertEquals(count, 1);
		}
		
		[Test]
		public function testModelsGetName():void {
			_soma.addModel(EmptyModel.NAME, new EmptyModel());
			assertEquals(_soma.getModel(EmptyModel.NAME).getName(), EmptyModel.NAME);
		}
		
		[Test]
		public function testModelsSetName():void {
			_soma.addModel(EmptyModel.NAME, new EmptyModel());
			_soma.getModel(EmptyModel.NAME).setName("new name");
			assertEquals(_soma.getModel(EmptyModel.NAME).getName(), "new name");
		}
		
		[Test]
		public function testModelsGetData():void {
			_soma.addModel(EmptyModel.NAME, new EmptyModel(this));
			assertEquals(_soma.getModel(EmptyModel.NAME).data, this);
		}
		
		[Test]
		public function testModelsSetData():void {
			_soma.addModel(EmptyModel.NAME, new EmptyModel());
			_soma.getModel(EmptyModel.NAME).data = this;
			assertEquals(_soma.getModel(EmptyModel.NAME).data, this);
		}
		
		[Test]
		public function testModelsDefaultDispatcher():void {
			_soma.addModel(EmptyModel.NAME, new EmptyModel());
			assertEquals(_soma.getModel(EmptyModel.NAME).dispatcher, _soma);
		}
		
		[Test]
		public function testModelsDefaultDispatcherInjection():void {
			var model:EmptyModel = _somaInjection.injector.createInstance(EmptyModel) as EmptyModel;
			assertEquals(model.dispatcher, _somaInjection);
		}
		
		[Test]
		public function testModelsGetDispatcher():void {
			var dispatcher:IEventDispatcher = new EventDispatcher();
			_soma.addModel(EmptyModel.NAME, new EmptyModel(null, dispatcher));
			assertEquals(_soma.getModel(EmptyModel.NAME).dispatcher, dispatcher);
		}
		
		[Test]
		public function testModelsSetDispatcher():void {
			var dispatcher:IEventDispatcher = new EventDispatcher();
			_soma.addModel(EmptyModel.NAME, new EmptyModel());
			_soma.getModel(EmptyModel.NAME).dispatcher = dispatcher;
			assertEquals(_soma.getModel(EmptyModel.NAME).dispatcher, dispatcher);
		}
		
		[Test(async)]
		public function testModelInitialize():void {
			var model:Model = new EmptyModel();
			_soma.addEventListener(EmptyModel.EVENT_INITIALIZED, Async.asyncHandler(this, modelVerifyInitializeSuccess, 100, model, modelVerifyInitializeFailed), false, 0, true);
			_soma.addModel(EmptyModel.NAME, model);
		}

		[Test(async)]
		public function testModelInitializeInjection():void {
			_somaInjection.addEventListener(EmptyModel.EVENT_INITIALIZED, Async.asyncHandler(this, modelVerifyInitializeSuccess, 100, null, modelVerifyInitializeFailed), false, 0, true);
			_somaInjection.injector.createInstance(EmptyModel);
		}

		private function modelVerifyInitializeFailed(model:Model):void {
			fail("ERROR, Model not initialized: " + model);
		}
		
		private function modelVerifyInitializeSuccess(event:Event, model:Model):void {
			
		}

	}
}