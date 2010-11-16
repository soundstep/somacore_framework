package com.soundstep.somacolor.controllers.commands {
	import com.soma.core.controller.ParallelCommand;
	import com.soma.core.interfaces.IParallelCommand;
	import com.soundstep.somacolor.controllers.events.ColorEvent;
	import com.soundstep.somacolor.controllers.events.MoveViewEvent;

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
	
	public class ParallelTestCommand extends ParallelCommand implements IParallelCommand {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		

		//------------------------------------
		// public properties
		//------------------------------------
		
		
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		public function ParallelTestCommand() {
			
		}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		override protected function initializeSubCommands():void {
			addSubCommand(new ColorEvent(ColorEvent.CHANGE_COLOR, Math.random() * 0xFFFFFF));
			addSubCommand(new MoveViewEvent(MoveViewEvent.MOVE_VIEW, Math.floor(Math.random() * 100), Math.floor(Math.random() * 100)));
		}
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		
		
	}
}