package com.soma.core.tests.suites.facade {

	import com.soma.core.tests.suites.support.EmptyViewMediator;
	import com.soma.core.di.SomaInjector;
	import flash.events.Event;
	import org.flexunit.asserts.fail;
	import org.flexunit.async.Async;
	import com.soma.core.tests.suites.support.TestSequenceCommand;
	import com.soma.core.tests.suites.support.EmptyView;
	import com.soma.core.tests.suites.support.EmptyModel;
	import com.soma.core.tests.suites.support.EmptyWire;
	import com.soma.core.tests.suites.support.TestAsyncCommand;
	import com.soma.core.tests.suites.support.TestEvent;
	import org.flexunit.asserts.assertNull;
	import com.soma.core.Soma;
	import flash.display.Stage;
	import mx.core.FlexGlobals;
		/**	 * <b>Author:</b> Romuald Quantin - <a href="http://www.soundstep.com/" target="_blank">www.soundstep.com</a><br />	 * <b>Class version:</b> 1.0<br />	 * <b>Actionscript version:</b> 3.0<br />	 * <b>Date:</b> Oct 6, 2010<br />	 * @example	 * <listing version="3.0"></listing>	 */		public class DisposingTest {

		private var _soma:Soma;		private var _somaInjection:Soma;		
		private static var _stage:Stage;
				[BeforeClass]
		public static function runBeforeClass():void {
			_stage = FlexGlobals.topLevelApplication.stage;		}				[AfterClass]		public static function runAfterClass():void {			_stage = null;		} 				[Before]		public function runBefore():void {			_soma = new Soma(_stage);			_somaInjection = new Soma(_stage, SomaInjector);		}				[After]		public function runAfter():void {			_soma.dispose();			_soma = null;			_somaInjection.dispose();			_somaInjection = null;		}				[Test]		public function testDisposeElements():void {
			_soma.addCommand(TestEvent.TEST, TestAsyncCommand);			_soma.addCommand(TestEvent.TEST_SEQUENCE, TestSequenceCommand);			_soma.dispatchEvent(new TestEvent(TestEvent.TEST_SEQUENCE));
			_soma.addWire(EmptyWire.NAME, new EmptyWire());			_soma.addModel(EmptyModel.NAME, new EmptyModel());			_soma.addView(EmptyView.NAME, new EmptyView());
			_soma.dispose();
			_somaInjection.dispose();
			assertNull(_soma.stage);
			assertNull(_soma.wires);
			assertNull(_soma.getWire(EmptyWire.NAME));
			assertNull(_soma.controller);			assertNull(_soma.getCommand(TestEvent.TEST_SEQUENCE));			assertNull(_soma.models);			assertNull(_soma.getModel(EmptyModel.NAME));			assertNull(_soma.views);			assertNull(_soma.getView(EmptyView.NAME));			assertNull(_soma.getCommands());			assertNull(_soma.getLastSequencer());			assertNull(_soma.getRunningSequencers());			assertNull(_soma.mediators);
			assertNull(_soma.injector);
			assertNull(_somaInjection.injector);		}				private function disposeCallTimeOut(obj:Object):void {
			fail("Dispose method not called in element: " + obj);
		}

		private function disposeCallSuccess(e:Event, obj:Object):void {			
		}
		
		[Test(async)]		public function testWireDisposeCallFromGlobalDispose():void {			_soma.addWire(EmptyWire.NAME, new EmptyWire());			_soma.addEventListener(EmptyWire.EVENT_DISPOSED, Async.asyncHandler(this, disposeCallSuccess, 100, "Wire", disposeCallTimeOut), false, 0, true);			_soma.dispose();		}		[Test(async)]
		public function testWireDisposeCallFromRemove():void {
			_soma.addWire(EmptyWire.NAME, new EmptyWire());
			_soma.addEventListener(EmptyWire.EVENT_DISPOSED, Async.asyncHandler(this, disposeCallSuccess, 100, "Wire", disposeCallTimeOut), false, 0, true);
			_soma.removeWire(EmptyWire.NAME);
		}

		[Test(async)]		public function testModelDisposeCallFromGlobalDispose():void {			_soma.addModel(EmptyModel.NAME, new EmptyModel("data"));			_soma.addEventListener(EmptyModel.EVENT_DISPOSED, Async.asyncHandler(this, disposeCallSuccess, 100, "Model", disposeCallTimeOut), false, 0, true);			_soma.dispose();		}		[Test(async)]		public function testModelDisposeCallFromRemove():void {			_soma.addModel(EmptyModel.NAME, new EmptyModel("data"));			_soma.addEventListener(EmptyModel.EVENT_DISPOSED, Async.asyncHandler(this, disposeCallSuccess, 100, "Model", disposeCallTimeOut), false, 0, true);			_soma.removeModel(EmptyModel.NAME);		}		[Test(async)]		public function testViewDisposeCallFromGlobalDispose():void {			_soma.addView(EmptyView.NAME, new EmptyView());			_soma.getView(EmptyView.NAME).addEventListener(EmptyView.EVENT_DISPOSED, Async.asyncHandler(this, disposeCallSuccess, 100, "View", disposeCallTimeOut), false, 0, true);			_soma.dispose();		}		[Test(async)]		public function testViewDisposeCallFromRemove():void {			_soma.addView(EmptyView.NAME, new EmptyView());			_soma.getView(EmptyView.NAME).addEventListener(EmptyView.EVENT_DISPOSED, Async.asyncHandler(this, disposeCallSuccess, 100, "View", disposeCallTimeOut), false, 0, true);			_soma.removeView(EmptyView.NAME);		}		[Test(async)]		public function testMediatorCallDispose():void {			_soma.mediators.map(EmptyView, EmptyViewMediator);			var view:EmptyView = new EmptyView();			_soma.addEventListener(EmptyViewMediator.EVENT_DISPOSED, Async.asyncHandler(this, disposeCallSuccess, 100, {view:view, instance:_soma}, disposeCallTimeOut), false, 0, true);			_stage.addChild(view);			_stage.removeChild(view);		}				[Test(async)]		public function testMediatorCallDisposeInjection():void {			_somaInjection.mediators.map(EmptyView, EmptyViewMediator);			var view:EmptyView = new EmptyView();			_somaInjection.addEventListener(EmptyViewMediator.EVENT_DISPOSED, Async.asyncHandler(this, disposeCallSuccess, 100, {view:view, instance:_somaInjection}, disposeCallTimeOut), false, 0, true);			_stage.addChild(view);			_stage.removeChild(view);		}			}}