package com.soma.core.tests.suites.commands {
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
		public function testHasCommand():void {
			var soma:ISoma = new Soma(_stage);
			soma.addCommand("event type", Command);
			assertTrue(soma.hasCommand("event type"));
		}
		
		[Test]
		public function testGetCommand():void {
			var soma:ISoma = new Soma(_stage);
			soma.addCommand("event type", Command);
			assertThat(soma.getCommand("event type"), instanceOf(Class));
		}
		
		[Test]
		public function testRemoveCommand():void {
			var soma:ISoma = new Soma(_stage);
			soma.addCommand("event type", Command);
			soma.removeCommand("event type");
			assertNull(soma.getCommand("event type"));
		}
		
		[Test]
		public function testCommandsLength():void {
			var soma:ISoma = new Soma(_stage);
			soma.addCommand("event type", Command);
			assertEquals(soma.getCommands().length, 1);
		}
		
	}
}