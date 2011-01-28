package com.soma.core.tests.suites.mediators {
	import com.soma.core.Soma;
	import com.soma.core.di.SomaInjector;
	import com.soma.core.interfaces.ISoma;
	import com.soma.core.tests.suites.support.EmptyView;
	import com.soma.core.tests.suites.support.EmptyViewMediator;
	import com.soma.core.tests.suites.support.IEmptyView;

	import org.flexunit.assertThat;
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertTrue;
	import org.flexunit.asserts.fail;
	import org.flexunit.async.Async;
	import org.hamcrest.object.instanceOf;

	import mx.core.FlexGlobals;

	import flash.display.Stage;
	import flash.events.Event;
	
	/**
	 * <b>Author:</b> Romuald Quantin - <a href="http://www.soundstep.com/" target="_blank">www.soundstep.com</a><br />
	 * <b>Class version:</b> 1.0<br />
	 * <b>Actionscript version:</b> 3.0<br />
	 * <b>Date:</b> Oct 6, 2010<br />
	 * @example
	 * <listing version="3.0"></listing>
	 */
	
	public class MediatorsTests {
		
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
		public function testMediatorIsMapped():void {
			_soma.mediators.map(EmptyView, EmptyViewMediator);
			assertTrue(_soma.mediators.isMapped(EmptyView));
		}
		
		[Test]
		public function testMediatorInterfaceIsMapped():void {
			_soma.mediators.map(IEmptyView, EmptyViewMediator);
			assertTrue(_soma.mediators.isMapped(IEmptyView));
		}
		
		[Test]
		public function testMediatorIsNotMapped():void {
			assertFalse(_soma.mediators.isMapped(EmptyView));		}
		
		[Test]
		public function testMediatorIsUnMapped():void {
			_soma.mediators.map(EmptyView, EmptyViewMediator);
			_soma.mediators.unmap(EmptyView);
			assertFalse(_soma.mediators.isMapped(EmptyView));
		}
		
		[Test]
		public function testMediatorInterfaceIsUnMapped():void {
			_soma.mediators.map(IEmptyView, EmptyViewMediator);
			_soma.mediators.unmap(IEmptyView);
			assertFalse(_soma.mediators.isMapped(IEmptyView));
		}
		
		[Test]
		public function testViewHasMediator():void {
			_soma.mediators.map(EmptyView, EmptyViewMediator);
			var view:EmptyView = new EmptyView();
			_stage.addChild(view);
			assertTrue(_soma.mediators.hasMediator(view));
			_stage.removeChild(view);
		}
		
		[Test]
		public function testViewHasMediatorInjection():void {
			_somaInjection.mediators.map(EmptyView, EmptyViewMediator);
			var view:EmptyView = new EmptyView();
			_stage.addChild(view);
			assertTrue(_somaInjection.mediators.hasMediator(view));
			_stage.removeChild(view);
		}
		
		[Test]
		public function testGetMediatorByView():void {
			_soma.mediators.map(EmptyView, EmptyViewMediator);
			var view:EmptyView = new EmptyView();
			_stage.addChild(view);
			assertThat(_soma.mediators.getMediatorByView(view), instanceOf(EmptyViewMediator));
			_stage.removeChild(view);
		}
		
		[Test]
		public function testGetMediatorByViewInjection():void {
			_somaInjection.mediators.map(EmptyView, EmptyViewMediator);
			var view:EmptyView = new EmptyView();
			_stage.addChild(view);
			assertThat(_somaInjection.mediators.getMediatorByView(view), instanceOf(EmptyViewMediator));
			_stage.removeChild(view);
		}
		
		[Test(async)]
		public function testMediatorInitialized():void {
			_soma.mediators.map(EmptyView, EmptyViewMediator);
			var view:EmptyView = new EmptyView();
			_soma.addEventListener(EmptyViewMediator.EVENT_INITIALIZED, Async.asyncHandler(this, mediatorVerifyInitializeSuccess, 100, {view:view}, mediatorVerifyInitializeFailed), false, 0, true);
			_stage.addChild(view);
		}
		
		[Test(async)]
		public function testMediatorInitializedInjection():void {
			_somaInjection.mediators.map(EmptyView, EmptyViewMediator);
			var view:EmptyView = new EmptyView();
			_somaInjection.addEventListener(EmptyViewMediator.EVENT_INITIALIZED, Async.asyncHandler(this, mediatorVerifyInitializeSuccess, 100, {view:view}, mediatorVerifyInitializeFailed), false, 0, true);
			_stage.addChild(view);
		}
		
		[Test(async)]
		public function testMediatorViewComponent():void {
			_soma.mediators.map(EmptyView, EmptyViewMediator);
			var view:EmptyView = new EmptyView();
			_soma.addEventListener(EmptyViewMediator.EVENT_INITIALIZED, Async.asyncHandler(this, mediatorVerifyViewComponentSuccess, 100, {view:view, instance:_soma}, mediatorVerifyViewComponentFailed), false, 0, true);
			_stage.addChild(view);
		}
		
		[Test(async)]
		public function testMediatorViewComponentInjection():void {
			_somaInjection.mediators.map(EmptyView, EmptyViewMediator);
			var view:EmptyView = new EmptyView();
			_somaInjection.addEventListener(EmptyViewMediator.EVENT_INITIALIZED, Async.asyncHandler(this, mediatorVerifyViewComponentSuccess, 100, {view:view, instance:_somaInjection}, mediatorVerifyViewComponentFailed), false, 0, true);
			_stage.addChild(view);
		}
		
		[Test(async)]
		public function testMediatorPairViewInjection():void {
			_somaInjection.mediators.map(EmptyView, EmptyViewMediator);
			var view:EmptyView = new EmptyView();
			_somaInjection.addEventListener(EmptyViewMediator.EVENT_INITIALIZED, Async.asyncHandler(this, mediatorVerifyPairViewSuccess, 100, {view:view, instance:_somaInjection}, mediatorVerifyPairViewFailed), false, 0, true);
			_stage.addChild(view);
		}
		
		[Test(async)]
		public function testMediatorPairViewInterfaceInjection():void {
			_somaInjection.mediators.map(IEmptyView, EmptyViewMediator);
			var view:EmptyView = new EmptyView();
			_somaInjection.addEventListener(EmptyViewMediator.EVENT_INITIALIZED, Async.asyncHandler(this, mediatorVerifyPairViewSuccess, 100, {view:view, instance:_somaInjection}, mediatorVerifyPairViewFailed), false, 0, true);
			_stage.addChild(view);
		}
		
		private function mediatorVerifyInitializeFailed(data:Object):void {
			fail("ERROR, Mediator not initialized.");
			_stage.removeChild(data.view);
		}
		
		private function mediatorVerifyViewComponentFailed(data:Object):void {
			fail("ERROR, viewComponent not set in mediator.");
			_stage.removeChild(data.view);
		}

		private function mediatorVerifyPairViewFailed(data:Object):void {
			fail("ERROR, pair view not injected in mediator.");
			_stage.removeChild(data.view);
		}

		private function mediatorVerifyInitializeSuccess(event:Event, data:Object):void {
			_stage.removeChild(data.view);
		}

		private function mediatorVerifyViewComponentSuccess(event:Event, data:Object):void {
			var instance:ISoma = data.instance as ISoma;
			assertEquals(instance.mediators.getMediatorByView(data.view).viewComponent, data.view);
			_stage.removeChild(data.view);
		}

		private function mediatorVerifyPairViewSuccess(event:Event, data:Object):void {
			var instance:ISoma = data.instance as ISoma;
			var mediator:EmptyViewMediator = instance.mediators.getMediatorByView(data.view) as EmptyViewMediator;
			assertEquals(mediator.view, data.view);
			_stage.removeChild(data.view);
		}

	}
}