package com.soma.core.tests.suites.support {
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	import com.soma.core.interfaces.ISequenceCommand;
	import flash.events.Event;
	import com.soma.core.controller.Command;
	import com.soma.core.interfaces.ICommandASync;
	
	/**
	 * <b>Author:</b> Romuald Quantin - <a href="http://www.soundstep.com/" target="_blank">www.soundstep.com</a><br />
	 * <b>Class version:</b> 1.0<br />
	 * <b>Actionscript version:</b> 3.0<br />
	 * <b>Date:</b> Oct 10, 2010<br />
	 * @example
	 * <listing version="3.0"></listing>
	 */
	
	public class TestAsyncCommand extends Command implements ICommandASync {

		// ------------------------------------
		// private, protected properties
		//------------------------------------
		
		private var _event:Event;
		private var _sequencer:ISequenceCommand;
		private var _timer:uint;

		//------------------------------------
		// public properties
		//------------------------------------
		
		
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		public function TestAsyncCommand() {
			
		}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		//
		// PUBLIC
		//________________________________________________________________________________________________
		
		public function execute(event:Event):void {
			_event = event;
			_sequencer = getSequencer(_event);
			_timer = setTimeout(result, 200, {});
		}

		public function dispose():void {
			_event = null;
			_sequencer = null;
			clearTimeout(_timer);
		}
		
		public function fault(info:Object):void {
			
		}
		
		public function result(data:Object):void {
			var dispatchEndSequence:Boolean = false;
			dispatchEvent(new TestEvent(TestEvent.TEST_ASYNC_COMPLETE, _event));
			if (isPartOfASequence(_event)) {
				if (_sequencer.length == 0) dispatchEndSequence = true;
				_sequencer.executeNextCommand();
			}
			if (dispatchEndSequence) dispatchEvent(new TestEvent(TestEvent.TEST_SEQUENCE_COMPLETE, _event));
			dispose();
		}

	}
}