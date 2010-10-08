package com.soma.core.tests.suites.commands {
	import com.soma.core.tests.suites.support.EmptyWire;
	import org.flexunit.asserts.fail;
	import flash.events.Event;
	import org.flexunit.async.Async;
	import com.soma.core.interfaces.IWire;
	import com.soma.core.wire.Wire;
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertNull;
	import org.hamcrest.object.instanceOf;
	import org.hamcrest.assertThat;
	import com.soma.core.controller.Command;
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
	
	public class CommandsTests {
		
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
		public function testHasCommandOnInstance():void {
			var soma:ISoma = new Soma(_stage);
			soma.addCommand("event type", Command);
			assertTrue(soma.hasCommand("event type"));
		}
		
		[Test]
		public function testGetCommandOnInstance():void {
			var soma:ISoma = new Soma(_stage);
			soma.addCommand("event type", Command);
			assertThat(soma.getCommand("event type"), instanceOf(Class)); 
		}
		
		[Test]
		public function testRemoveCommandOnInstance():void {
			var soma:ISoma = new Soma(_stage);
			soma.addCommand("event type", Command);
			soma.removeCommand("event type");
			assertNull(soma.getCommand("event type"));
		}
		
		[Test]
		public function testCommandsLengthOnInstance():void {
			var soma:ISoma = new Soma(_stage);
			soma.addCommand("event type", Command);
			assertEquals(soma.getCommands().length, 1);
		}
		
		[Test(async)]
		public function testHasCommandOnWire():void {
//			var soma:ISoma = new Soma(_stage);
//			var wire:Wire = new EmptyWire();
//			soma.addEventListener(Event.COMPLETE, Async.asyncHandler(this, wireVerifyHasCommand, 100, wire, handleEventNeverOccurred), false, 0, true);
//			wire.addCommand("event type", Command);
//			soma.addWire(EmptyWire.NAME, wire as IWire);
//			http://docs.flexunit.org/index.php?title=Using_Asynchronous_Startup
		}

		private function handleEventNeverOccurred(obj:Object):void {
			fail("ERROR, event never occured"); obj;
		}

		private function wireVerifyHasCommand(event:Event, wire:Wire):void {
			assertTrue(wire.hasCommand("event type"));
		}
		
//		[Test]
//		public function testGetCommandOnWire():void {
//			var soma:ISoma = new Soma(_stage);
//			var wire:Wire = new Wire("wire name");
//			soma.addWire("wire name", wire as IWire);
//			wire.addCommand("event type", Command);
//			assertThat(wire.getCommand("event type"), instanceOf(Class)); 
//		}
//		
//		[Test]
//		public function testRemoveCommandOnWire():void {
//			var soma:ISoma = new Soma(_stage);
//			var wire:Wire = new Wire("wire name");
//			soma.addWire("wire name", wire as IWire);
//			wire.addCommand("event type", Command);
//			wire.removeCommand("event type");
//			assertNull(wire.getCommand("event type"));
//		}
//		
//		[Test]
//		public function testCommandsLengthOnWire():void {
//			var soma:ISoma = new Soma(_stage);
//			var wire:Wire = new Wire("wire name");
//			soma.addWire("wire name", wire as IWire);
//			wire.addCommand("event type", Command);
//			assertEquals(wire.getCommands().length, 1);
//		}
		
	}
}