package com.soma.core.tests.suites.commands {
	import org.flexunit.asserts.assertEquals;
	import com.soma.core.interfaces.ISequenceCommand;
	import org.flexunit.asserts.assertNull;
	import org.flexunit.asserts.assertTrue;
	import org.hamcrest.assertThat;
	import org.flexunit.asserts.fail;
	import org.flexunit.async.Async;
	import flash.events.Event;
	import mx.core.FlexGlobals;
	import flash.display.Stage;
	import com.soma.core.Soma;
	import com.soma.core.interfaces.ISoma;
	import com.soma.core.tests.suites.support.TestAsyncCommand;
	import com.soma.core.tests.suites.support.TestEvent;
	import com.soma.core.tests.suites.support.TestSequenceCommand;

	import org.hamcrest.object.instanceOf;		/**	 * <b>Author:</b> Romuald Quantin - <a href="http://www.soundstep.com/" target="_blank">www.soundstep.com</a><br />	 * <b>Class version:</b> 1.0<br />	 * <b>Actionscript version:</b> 3.0<br />	 * <b>Date:</b> Oct 10, 2010<br />	 * @example	 * <listing version="3.0"></listing>	 */		public class SequenceTests {

		private static var _stage:Stage;
				[BeforeClass]
		public static function runBeforeClass():void {
			_stage = FlexGlobals.topLevelApplication.stage;		}				[AfterClass]		public static function runAfterClass():void {			_stage = null;		} 				[Before]		public function runBefore():void {					}				[After]		public function runAfter():void {					}				[Test(async)]		public function testGetSequencer():void {			var soma:ISoma = new Soma(_stage);			soma.addCommand(TestEvent.TEST, TestAsyncCommand);
			soma.addCommand(TestEvent.TEST_SEQUENCE, TestSequenceCommand);
			soma.addEventListener(TestEvent.TEST_ASYNC_COMPLETE, Async.asyncHandler(this, testGetSequencerHandler, 500, soma, sequencerErrorHandler));
			soma.dispatchEvent(new TestEvent(TestEvent.TEST_SEQUENCE));			
		}

		private function sequencerErrorHandler(instance:ISoma):void {
			fail("SequenceCommand has not been executed under 500ms");
			instance.dispose();
			instance = null;
		}

		private function testGetSequencerHandler(event:TestEvent, instance:ISoma):void {
			assertThat(instance.getSequencer(Event(event.data)), instanceOf(TestSequenceCommand));
			instance.stopAllSequencers();
			instance.dispose();			instance = null;
		}				[Test(async)]
		public function testStopSequencerWithEvent():void {
			var soma:ISoma = new Soma(_stage);
			soma.addCommand(TestEvent.TEST, TestAsyncCommand);
			soma.addCommand(TestEvent.TEST_SEQUENCE, TestSequenceCommand);
			soma.addEventListener(TestEvent.TEST_ASYNC_COMPLETE, Async.asyncHandler(this, testStopSequencerWithEventHandler, 500, soma, sequencerErrorHandler));
			soma.dispatchEvent(new TestEvent(TestEvent.TEST_SEQUENCE));
		}

		private function testStopSequencerWithEventHandler(event:TestEvent, instance:ISoma):void {
			assertTrue((instance.stopSequencerWithEvent(Event(event.data))));
			assertNull(instance.getSequencer(Event(event.data)));
			instance.stopAllSequencers();
			instance.dispose();
			instance = null;
		}
		
		[Test(async)]
		public function testStopSequencer():void {
			var soma:ISoma = new Soma(_stage);
			soma.addCommand(TestEvent.TEST, TestAsyncCommand);
			soma.addCommand(TestEvent.TEST_SEQUENCE, TestSequenceCommand);
			soma.addEventListener(TestEvent.TEST_ASYNC_COMPLETE, Async.asyncHandler(this, testStopSequencerHandler, 500, soma, sequencerErrorHandler));
			soma.dispatchEvent(new TestEvent(TestEvent.TEST_SEQUENCE));
		}

		private function testStopSequencerHandler(event:TestEvent, instance:ISoma):void {
			var sequencer:ISequenceCommand = instance.getSequencer(Event(event.data));
			assertTrue(instance.stopSequencer(sequencer));
			instance.stopAllSequencers();
			instance.dispose();
			instance = null;
		}
		
		[Test(async)]
		public function testGetRunningSequencers():void {
			var soma:ISoma = new Soma(_stage);
			soma.addCommand(TestEvent.TEST, TestAsyncCommand);
			soma.addCommand(TestEvent.TEST_SEQUENCE, TestSequenceCommand);
			soma.addEventListener(TestEvent.TEST_ASYNC_COMPLETE, Async.asyncHandler(this, testGetRunningSequencersHandler, 500, soma, sequencerErrorHandler));
			soma.dispatchEvent(new TestEvent(TestEvent.TEST_SEQUENCE));
		}

		private function testGetRunningSequencersHandler(event:TestEvent, instance:ISoma):void {
			var array:Array = instance.getRunningSequencers();
			assertEquals(array.length, 1);
			assertThat(array[0], instanceOf(TestSequenceCommand));
			instance.stopAllSequencers();
			instance.dispose();
			instance = null;
		}
		
		[Test(async)]
		public function testStopAllSequencers():void {
			var soma:ISoma = new Soma(_stage);
			soma.addCommand(TestEvent.TEST, TestAsyncCommand);
			soma.addCommand(TestEvent.TEST_SEQUENCE, TestSequenceCommand);
			soma.addEventListener(TestEvent.TEST_ASYNC_COMPLETE, Async.asyncHandler(this, testStopAllSequencersHandler, 500, soma, sequencerErrorHandler));
			soma.dispatchEvent(new TestEvent(TestEvent.TEST_SEQUENCE));
		}

		private function testStopAllSequencersHandler(event:TestEvent, instance:ISoma):void {
			instance.stopAllSequencers();
			var sequencer:ISequenceCommand = instance.getSequencer(Event(event.data));
			var array:Array = instance.getRunningSequencers();
			assertEquals(array.length, 0);
			assertNull(sequencer);
			instance.dispose();
			instance = null;
		}
		
		[Test(async)]
		public function testIsPartOfASequence():void {
			var soma:ISoma = new Soma(_stage);
			soma.addCommand(TestEvent.TEST, TestAsyncCommand);
			soma.addCommand(TestEvent.TEST_SEQUENCE, TestSequenceCommand);
			soma.addEventListener(TestEvent.TEST_ASYNC_COMPLETE, Async.asyncHandler(this, testIsPartOfASequenceHandler, 500, soma, sequencerErrorHandler));
			soma.dispatchEvent(new TestEvent(TestEvent.TEST_SEQUENCE));
		}

		private function testIsPartOfASequenceHandler(event:TestEvent, instance:ISoma):void {
			assertTrue(instance.isPartOfASequence(Event(event.data)));
			instance.stopAllSequencers();
			instance.dispose();
			instance = null;
		}
		
		[Test(async)]
		public function testGetLastSequencer():void {
			var soma:ISoma = new Soma(_stage);
			soma.addCommand(TestEvent.TEST, TestAsyncCommand);
			soma.addCommand(TestEvent.TEST_SEQUENCE, TestSequenceCommand);
			soma.addEventListener(TestEvent.TEST_ASYNC_COMPLETE, Async.asyncHandler(this, testGetLastSequencerHandler, 500, soma, sequencerErrorHandler));
			soma.dispatchEvent(new TestEvent(TestEvent.TEST_SEQUENCE));
		}

		private function testGetLastSequencerHandler(event:TestEvent, instance:ISoma):void {
			assertThat(instance.getLastSequencer(), instanceOf(TestSequenceCommand));
			instance.stopAllSequencers();
			instance.dispose();
			instance = null;
		}
		
	}}