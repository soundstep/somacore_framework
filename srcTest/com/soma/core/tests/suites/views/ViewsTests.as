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
		
		private var _soma:ISoma;
		
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
		}
		
		[After]
		public function runAfter():void {
			_soma.dispose();			_soma = null;
		}
		
		[Test]
		public function testHasView():void {
			_soma.addView(EmptyView.NAME, new EmptyView());
			assertTrue(_soma.hasView(EmptyView.NAME));
		}
		
		[Test]
		public function testGetView():void {
			_soma.addView(EmptyView.NAME, new EmptyView());
			assertThat(_soma.getView(EmptyView.NAME), instanceOf(EmptyView));
		}
		
		[Test]
		public function testRemoveView():void {
			_soma.addView(EmptyView.NAME, new EmptyView());
			_soma.removeView(EmptyView.NAME);
			assertNull(_soma.getView(EmptyView.NAME));
		}
		
		[Test]
		public function testViewsLength():void {
			_soma.addView(EmptyView.NAME, new EmptyView());
			var count:int = 0;
			for (var view:String in _soma.getViews()) {
				if (view) count++;
			}
			assertEquals(count, 1);
		}
		
		[Test(async)]
		public function testViewInitialize():void {
			var view:EmptyView = new EmptyView();
			view.addEventListener(EmptyView.EVENT_INITIALIZED, Async.asyncHandler(this, viewVerifyInitializeSuccess, 100, view, viewVerifyInitializeFailed), false, 0, true);
			_soma.addView(EmptyView.NAME, view);
		}

		private function viewVerifyInitializeFailed(view:Object):void {
			fail("ERROR, view not initialized: " + view);
		}
		
		private function viewVerifyInitializeSuccess(event:Event, view:Object):void {
			
		}

	}
}