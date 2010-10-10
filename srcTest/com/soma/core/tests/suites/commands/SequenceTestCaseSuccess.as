package com.soma.core.tests.suites.commands {
	import flexunit.framework.TestCase;
	import flash.events.Event;
	import com.soma.core.tests.suites.support.TestSequenceCommand;
	import mx.core.FlexGlobals;
	import flash.display.Stage;
	import com.soma.core.tests.suites.support.TestAsyncCommand;
	import com.soma.core.tests.suites.support.TestEvent;
	import com.soma.core.Soma;
		/**	 * <b>Author:</b> Romuald Quantin - <a href="http://www.soundstep.com/" target="_blank">www.soundstep.com</a><br />	 * <b>Class version:</b> 1.0<br />	 * <b>Actionscript version:</b> 3.0<br />	 * <b>Date:</b> Oct 10, 2010<br />	 * @example	 * <listing version="3.0"></listing>	 */		public class SequenceTestCaseSuccess extends TestCase {		//------------------------------------		// private, protected properties		//------------------------------------				private var _soma:Soma;
		private var _count:int;
		
		private static var _stage:Stage;
		//------------------------------------		// public properties		//------------------------------------								//------------------------------------		// constructor		//------------------------------------				public function SequenceTestCaseSuccess() {					}				//		// PRIVATE, PROTECTED		//________________________________________________________________________________________________		
		override public function setUp():void {			_stage = FlexGlobals.topLevelApplication.stage;
			_count = 0;
			_soma = new Soma(_stage);			_soma.addCommand(TestEvent.TEST, TestAsyncCommand);
			_soma.addCommand(TestEvent.TEST_SEQUENCE, TestSequenceCommand);		}
				override public function tearDown():void {
			var command:TestAsyncCommand = _soma.getCommand(TestEvent.TEST) as TestAsyncCommand;
			if (command) command.dispose();
			_soma.removeEventListener(TestEvent.TEST_ASYNC_COMPLETE, testSequenceHandler);
			_soma.dispose();			_soma = null;		}				// 		// PUBLIC
		// ________________________________________________________________________________________________
		
		public function testSequence():void {
			_soma.addEventListener(TestEvent.TEST_ASYNC_COMPLETE, addAsync(testSequenceHandler, 500));
			_soma.dispatchEvent(new TestEvent(TestEvent.TEST_SEQUENCE));
		}

		private function testSequenceHandler(event:TestEvent):void {
			_soma.removeEventListener(TestEvent.TEST_ASYNC_COMPLETE, testSequenceHandler);
			if (++_count < 5) {
				_soma.addEventListener(TestEvent.TEST_ASYNC_COMPLETE, addAsync(testSequenceHandler, 500));
			}
			else {
				_soma.addEventListener(TestEvent.TEST_SEQUENCE_COMPLETE, addAsync(testSequenceCompleteHandler, 100));
			}
			trace("TestSequenceCommand: step", _count + "/5");
		}

		private function testSequenceCompleteHandler(event:TestEvent):void {
			assertNull(_soma.getLastSequencer());			assertEquals(_soma.getRunningSequencers().length, 0);			assertNull(_soma.getSequencer(Event(event.data)));
		}
		
	}}