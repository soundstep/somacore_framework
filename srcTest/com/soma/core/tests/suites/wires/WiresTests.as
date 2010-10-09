package com.soma.core.tests.suites.wires {
	import flash.events.Event;
	import org.flexunit.asserts.fail;
	import org.flexunit.async.Async;
	import com.soma.core.wire.Wire;
	import com.soma.core.tests.suites.support.EmptyWire;
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
	
	public class WiresTests {
		
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
		public function testHasWire():void {
			var soma:ISoma = new Soma(_stage);
			soma.addWire(EmptyWire.NAME, new EmptyWire());
			assertTrue(soma.hasWire(EmptyWire.NAME));
		}
		
		[Test]
		public function testGetWire():void {
			var soma:ISoma = new Soma(_stage);
			soma.addWire(EmptyWire.NAME, new EmptyWire());
			assertThat(soma.getWire(EmptyWire.NAME), instanceOf(EmptyWire));
		}
		
		[Test]
		public function testRemoveWire():void {
			var soma:ISoma = new Soma(_stage);
			soma.addWire(EmptyWire.NAME, new EmptyWire());
			soma.removeWire(EmptyWire.NAME);
			assertNull(soma.getWire(EmptyWire.NAME));
		}
		
		[Test]
		public function testWiresLength():void {
			var soma:ISoma = new Soma(_stage);
			soma.addWire(EmptyWire.NAME, new EmptyWire());
			var count:int = 0;
			for (var wire:String in soma.getWires()) {
				if (wire) count++;
			}
			assertEquals(count, 1);
		}
		
		[Test]
		public function testWiresGetName():void {
			var soma:ISoma = new Soma(_stage);
			soma.addWire(EmptyWire.NAME, new EmptyWire());
			assertEquals(soma.getWire(EmptyWire.NAME).getName(), EmptyWire.NAME);
		}
		
		[Test]
		public function testWiresSetName():void {
			var soma:ISoma = new Soma(_stage);
			soma.addWire(EmptyWire.NAME, new EmptyWire());
			soma.getWire(EmptyWire.NAME).setName("new name");
			assertEquals(soma.getWire(EmptyWire.NAME).getName(), "new name");
		}
		
		[Test(async)]
		public function testWireInitialize():void {
			var soma:ISoma = new Soma(_stage);
			var wire:Wire = new EmptyWire();
			soma.addEventListener(EmptyWire.EVENT_INITIALIZED, Async.asyncHandler(this, wireVerifyInitializeSuccess, 100, wire, wireVerifyInitializeFailed), false, 0, true);
			soma.addWire(EmptyWire.NAME, wire);
		}

		private function wireVerifyInitializeFailed(wire:Wire):void {
			fail("ERROR, wire not initialized: " + wire);
		}
		
		private function wireVerifyInitializeSuccess(event:Event, wire:Wire):void {
			
		}

	}
}