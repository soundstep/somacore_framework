package com.soundstep.somacolor.controllers.commands {
	import com.greensock.easing.Expo;
	import com.soma.core.controller.SequenceCommand;
	import com.soma.core.interfaces.ISequenceCommand;
	import com.soundstep.somacolor.controllers.events.TweenEvent;
	import com.soundstep.somacolor.views.ColorSquare;

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
	
	public class TweenSequenceCommand extends SequenceCommand implements ISequenceCommand {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		

		//------------------------------------
		// public properties
		//------------------------------------
		
		[Inject]
		public var view:ColorSquare;
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		public function TweenSequenceCommand() {
			
		}
		
		private function getRandomTween():Object {
			var obj:Object = {};
			obj.tint = Math.random() * 0xFFFFFF;
			obj.x = Math.floor(Math.random() * (stage.stageWidth - 100));
			obj.y = Math.floor(Math.random() * (stage.stageHeight - 100));
			obj.ease = Expo.easeOut;
			return obj;
		}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		override protected function initializeSubCommands():void {
			addSubCommand(new TweenEvent(TweenEvent.TWEEN, view, 1, getRandomTween()));
			addSubCommand(new TweenEvent(TweenEvent.TWEEN, view, 1, getRandomTween()));
			addSubCommand(new TweenEvent(TweenEvent.TWEEN, view, 1, getRandomTween()));
			addSubCommand(new TweenEvent(TweenEvent.TWEEN, view, 1, getRandomTween()));
			addSubCommand(new TweenEvent(TweenEvent.TWEEN, view, 1, getRandomTween()));
			var lastObject:Object = getRandomTween();
			lastObject.x = 20;
			lastObject.y = 300;
			addSubCommand(new TweenEvent(TweenEvent.TWEEN, view, 1, lastObject));
		}
		
		// PUBLIC
		//________________________________________________________________________________________________
		
	}
}