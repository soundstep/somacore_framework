package com.soma.core.tests.suites.commands {
	import com.soma.core.tests.suites.support.EmptyModel;
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
			soma.addCommand(TestEvent.TEST, TestCommand);
			assertTrue(soma.hasCommand(TestEvent.TEST));
		}
		
		[Test]
		public function testGetCommand():void {
			var soma:ISoma = new Soma(_stage);
			soma.addCommand(TestEvent.TEST, TestCommand);
			assertThat(soma.getCommand(TestEvent.TEST), instanceOf(Class));
		}
		
		[Test]
		public function testRemoveCommand():void {
			var soma:ISoma = new Soma(_stage);
			soma.addCommand(TestEvent.TEST, TestCommand);
			soma.removeCommand(TestEvent.TEST);
			assertNull(soma.getCommand(TestEvent.TEST));
		}
		
		[Test]
		public function testCommandsLength():void {
			var soma:ISoma = new Soma(_stage);
			soma.addCommand(TestEvent.TEST, TestCommand);
			assertEquals(soma.getCommands().length, 1);
		}
		
		[Test(expects="Error")]
		public function testDoubleMapping():void {
			var soma:ISoma = new Soma(_stage);
			soma.addCommand(TestEvent.TEST, TestCommand);
			soma.addCommand(TestEvent.TEST, TestCommand);
		}

		[Test(expects="Error")]
		public function testMappingNonCommand():void {
			var soma:ISoma = new Soma(_stage);
			soma.addCommand(TestEvent.TEST, Object);
			soma.addModel(EmptyModel.NAME, new EmptyModel(this));
		}
		
	}
}