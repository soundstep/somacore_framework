package com.soma.core.tests.suites.commands {
	import com.soma.core.tests.suites.support.TestCommand;
	import com.soma.core.tests.suites.support.TestEvent;
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
	
	public class CommandsTests {
		
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
			_soma.addCommand(TestEvent.TEST, TestCommand);
		}
		
		[After]
		public function runAfter():void {
			_soma.dispose();
			_soma = null;
		}
		
		[Test]
		public function testHasCommand():void {
			assertTrue(_soma.hasCommand(TestEvent.TEST));
		}
		
		[Test]
		public function testGetCommand():void {
			assertThat(_soma.getCommand(TestEvent.TEST), instanceOf(Class));
		}
		
		[Test]
		public function testRemoveCommand():void {
			_soma.removeCommand(TestEvent.TEST);
			assertNull(_soma.getCommand(TestEvent.TEST));
		}
		
		[Test]
		public function testCommandsLength():void {
			assertEquals(_soma.getCommands().length, 1);
		}
		
		[Test(expects="Error")]
		public function testDoubleMapping():void {
			_soma.addCommand(TestEvent.TEST, TestCommand);
		}

		[Test(expects="Error")]
		public function testMappingNonCommand():void {
			_soma.addCommand(TestEvent.TEST, Object);
		}
		
	}
}