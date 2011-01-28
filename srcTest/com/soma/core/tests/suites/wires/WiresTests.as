package com.soma.core.tests.suites.wires {
	import com.soma.core.Soma;
	import com.soma.core.di.SomaInjector;
	import com.soma.core.interfaces.ISoma;
	import com.soma.core.tests.suites.support.EmptyWire;
	import com.soma.core.wire.Wire;

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
	
	/**
	 * <b>Author:</b> Romuald Quantin - <a href="http://www.soundstep.com/" target="_blank">www.soundstep.com</a><br />
	 * <b>Class version:</b> 1.0<br />
	 * <b>Actionscript version:</b> 3.0<br />
	 * <b>Date:</b> Oct 6, 2010<br />
	 * @example
	 * <listing version="3.0"></listing>
	 */
	
	public class WiresTests {
		
		private var _soma:ISoma;
		private var _somaInjection:Soma;
		
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
			_soma.dispose();			_soma = null;
			_somaInjection.dispose();
			_somaInjection = null;
		}
		
		[Test]
		public function testHasWire():void {
			_soma.addWire(EmptyWire.NAME, new EmptyWire());
			assertTrue(_soma.hasWire(EmptyWire.NAME));
		}
		
		[Test]
		public function testGetWire():void {
			_soma.addWire(EmptyWire.NAME, new EmptyWire());
			assertThat(_soma.getWire(EmptyWire.NAME), instanceOf(EmptyWire));
		}
		
		[Test]
		public function testRemoveWire():void {
			_soma.addWire(EmptyWire.NAME, new EmptyWire());
			_soma.removeWire(EmptyWire.NAME);
			assertNull(_soma.getWire(EmptyWire.NAME));
		}
		
		[Test]
		public function testWiresLength():void {
			_soma.addWire(EmptyWire.NAME, new EmptyWire());
			var count:int = 0;
			for (var wire:String in _soma.getWires()) {
				if (wire) count++;
			}
			assertEquals(count, 1);
		}
		
		[Test]
		public function testWiresGetName():void {
			_soma.addWire(EmptyWire.NAME, new EmptyWire());
			assertEquals(_soma.getWire(EmptyWire.NAME).getName(), EmptyWire.NAME);
		}
		
		[Test]
		public function testWiresSetName():void {
			_soma.addWire(EmptyWire.NAME, new EmptyWire());
			_soma.getWire(EmptyWire.NAME).setName("new name");
			assertEquals(_soma.getWire(EmptyWire.NAME).getName(), "new name");
		}
		
		[Test]
		public function testWireHasInstance():void {
			var wire:EmptyWire = _soma.addWire(EmptyWire.NAME, new EmptyWire()) as EmptyWire;
			assertEquals(_soma, wire.instance);
		}
		
		[Test]
		public function testWireHasInstanceInjected():void {
			var wire:EmptyWire = _somaInjection.injector.createInstance(EmptyWire) as EmptyWire;
			assertEquals(_somaInjection, wire.instance);
		}
		
		[Test(async)]
		public function testWireInitialize():void {
			var wire:Wire = new EmptyWire();
			_soma.addEventListener(EmptyWire.EVENT_INITIALIZED, Async.asyncHandler(this, wireVerifyInitializeSuccess, 100, wire, wireVerifyInitializeFailed), false, 0, true);
			_soma.addWire(EmptyWire.NAME, wire);
		}

		[Test(async)]
		public function testWireInitializeInjection():void {
			_somaInjection.addEventListener(EmptyWire.EVENT_INITIALIZED, Async.asyncHandler(this, wireVerifyInitializeSuccess, 100, null, wireVerifyInitializeFailed), false, 0, true);
			_somaInjection.injector.createInstance(EmptyWire);
		}

		private function wireVerifyInitializeFailed(wire:Wire):void {
			fail("ERROR, wire not initialized: " + wire);
		}
		
		private function wireVerifyInitializeSuccess(event:Event, wire:Wire):void {
			
		}

	}
}