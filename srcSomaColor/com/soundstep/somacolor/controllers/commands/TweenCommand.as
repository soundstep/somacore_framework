package com.soundstep.somacolor.controllers.commands {
	import com.greensock.TweenLite;

	import com.soma.core.controller.Command;
	import com.soma.core.interfaces.ICommandASync;
	import com.soundstep.somacolor.controllers.events.TweenEvent;

	import flash.events.Event;

	/**
	 * <b>Author:</b> Romuald Quantin - <a href="http://www.soundstep.com/" target="_blank">www.soundstep.com</a><br />* <b>Class version:</b> 1.0<br />
	 * <b>Actionscript version:</b> 3.0<br />
	 * <b>Copyright:</b> 
	 * <br />
	 * <b>Date:</b> Sep 22, 2009<br />
	 * <b>Usage:</b>
	 * @example
	 * <listing version="3.0"></listing>
	 */
	
	public class TweenCommand extends Command implements ICommandASync {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		

		//------------------------------------
		// public properties
		//------------------------------------
		
		[Inject]
		public var tweenEvent:TweenEvent;
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		public function TweenCommand() {
			
		}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		public function execute(event:Event):void {
			var obj:Object = tweenEvent.tweenObject;
			obj.onComplete = getSequencer(event).executeNextCommand;
			TweenLite.to(tweenEvent.tweenTarget, tweenEvent.tweenTime, obj);
		}

		public function fault(info:Object):void {
			trace("Error in " + this + " " + info);
		}
		
		public function result(data:Object):void {
			 
		}
		
	}
}