package com.soma.core.tests.suites.models {
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import com.soma.core.model.Model;
	import com.soma.core.tests.suites.support.EmptyModel;
	import flash.events.Event;
	import org.flexunit.asserts.fail;
	import org.flexunit.async.Async;
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertNull;
	import org.hamcrest.object.instanceOf;
	import org.hamcrest.assertThat;
	import com.soma.core.Soma;
	import com.soma.core.interfaces.ISoma;
	import org.flexunit.asserts.assertTrue;
	import flash.display.Stage;
	import mx.core.FlexGlobals;
	
	/**
	 * <b>Author:</b> Romuald Quantin - <a href="http://www.soundstep.com/" target="_blank">www.soundstep.com</a><br />
	 * <b>Class version:</b> 1.0<br />
	 * <b>Actionscript version:</b> 3.0<br />
	 * <b>Date:</b> Oct 6, 2010<br />
	 * @example
	 * <listing version="3.0"></listing>
	 */
	
	public class ModelsTests {
		
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
			
		}
		
		[After]
		public function runAfter():void {
			
		}
		
		[Test]
		public function testHasModel():void {
			var soma:ISoma = new Soma(_stage);
			soma.addModel(EmptyModel.NAME, new EmptyModel());
			assertTrue(soma.hasModel(EmptyModel.NAME));
		}
		
		[Test]
		public function testGetModel():void {
			var soma:ISoma = new Soma(_stage);
			soma.addModel(EmptyModel.NAME, new EmptyModel());
			assertThat(soma.getModel(EmptyModel.NAME), instanceOf(EmptyModel));
		}
		
		[Test]
		public function testRemoveModel():void {
			var soma:ISoma = new Soma(_stage);
			soma.addModel(EmptyModel.NAME, new EmptyModel());
			soma.removeModel(EmptyModel.NAME);
			assertNull(soma.getModel(EmptyModel.NAME));
		}
		
		[Test]
		public function testModelsLength():void {
			var soma:ISoma = new Soma(_stage);
			soma.addModel(EmptyModel.NAME, new EmptyModel());
			var count:int = 0;
			for (var model:String in soma.getModels()) {
				if (model) count++;
			}
			assertEquals(count, 1);
		}
		
		[Test]
		public function testModelsGetName():void {
			var soma:ISoma = new Soma(_stage);
			soma.addModel(EmptyModel.NAME, new EmptyModel());
			assertEquals(soma.getModel(EmptyModel.NAME).getName(), EmptyModel.NAME);
		}
		
		[Test]
		public function testModelsSetName():void {
			var soma:ISoma = new Soma(_stage);
			soma.addModel(EmptyModel.NAME, new EmptyModel());
			soma.getModel(EmptyModel.NAME).setName("new name");
			assertEquals(soma.getModel(EmptyModel.NAME).getName(), "new name");
		}
		
		[Test]
		public function testModelsGetData():void {
			var soma:ISoma = new Soma(_stage);
			soma.addModel(EmptyModel.NAME, new EmptyModel(this));
			assertEquals(soma.getModel(EmptyModel.NAME).data, this);
		}
		
		[Test]
		public function testModelsSetData():void {
			var soma:ISoma = new Soma(_stage);
			soma.addModel(EmptyModel.NAME, new EmptyModel());
			soma.getModel(EmptyModel.NAME).data = this;
			assertEquals(soma.getModel(EmptyModel.NAME).data, this);
		}
		
		[Test]
		public function testModelsDefaultDispatcher():void {
			var soma:ISoma = new Soma(_stage);
			soma.addModel(EmptyModel.NAME, new EmptyModel());
			assertEquals(soma.getModel(EmptyModel.NAME).dispatcher, soma);
		}
		
		[Test]
		public function testModelsGetDispatcher():void {
			var soma:ISoma = new Soma(_stage);
			var dispatcher:IEventDispatcher = new EventDispatcher();
			soma.addModel(EmptyModel.NAME, new EmptyModel(null, dispatcher));
			assertEquals(soma.getModel(EmptyModel.NAME).dispatcher, dispatcher);
		}
		
		[Test]
		public function testModelsSetDispatcher():void {
			var soma:ISoma = new Soma(_stage);
			var dispatcher:IEventDispatcher = new EventDispatcher();
			soma.addModel(EmptyModel.NAME, new EmptyModel());
			soma.getModel(EmptyModel.NAME).dispatcher = dispatcher;
			assertEquals(soma.getModel(EmptyModel.NAME).dispatcher, dispatcher);
		}
		
		[Test(async)]
		public function testModelInitialize():void {
			var soma:ISoma = new Soma(_stage);
			var model:Model = new EmptyModel();
			soma.addEventListener(EmptyModel.EVENT_INITIALIZED, Async.asyncHandler(this, modelVerifyInitializeSuccess, 100, model, modelVerifyInitializeFailed), false, 0, true);
			soma.addModel(EmptyModel.NAME, model);
		}

		private function modelVerifyInitializeFailed(model:Model):void {
			fail("ERROR, Model not initialized: " + model);
		}
		
		private function modelVerifyInitializeSuccess(event:Event, model:Model):void {
			
		}

	}
}