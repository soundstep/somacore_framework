package com.soma.core.tests.suites.views {
	import com.soma.core.tests.suites.support.EmptyView;
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
	
	public class ViewsTests {
		
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
		public function testHasView():void {
			var soma:ISoma = new Soma(_stage);
			soma.addView(EmptyView.NAME, new EmptyView());
			assertTrue(soma.hasView(EmptyView.NAME));
		}
		
		[Test]
		public function testGetView():void {
			var soma:ISoma = new Soma(_stage);
			soma.addView(EmptyView.NAME, new EmptyView());
			assertThat(soma.getView(EmptyView.NAME), instanceOf(EmptyView));
		}
		
		[Test]
		public function testRemoveView():void {
			var soma:ISoma = new Soma(_stage);
			soma.addView(EmptyView.NAME, new EmptyView());
			soma.removeView(EmptyView.NAME);
			assertNull(soma.getView(EmptyView.NAME));
		}
		
		[Test]
		public function testViewsLength():void {
			var soma:ISoma = new Soma(_stage);
			soma.addView(EmptyView.NAME, new EmptyView());
			var count:int = 0;
			for (var view:String in soma.getViews()) {
				if (view) count++;
			}
			assertEquals(count, 1);
		}
		
		[Test(async)]
		public function testViewInitialize():void {
			var soma:ISoma = new Soma(_stage);
			var view:EmptyView = new EmptyView();
			view.addEventListener(EmptyView.EVENT_INITIALIZED, Async.asyncHandler(this, viewVerifyInitializeSuccess, 100, view, viewVerifyInitializeFailed), false, 0, true);
			soma.addView(EmptyView.NAME, view);
		}

		private function viewVerifyInitializeFailed(view:Object):void {
			fail("ERROR, view not initialized: " + view);
		}
		
		private function viewVerifyInitializeSuccess(event:Event, view:Object):void {
			
		}

	}
}