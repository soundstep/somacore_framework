package com.soundstep.somacolor.controllers.commands {
	import com.soma.core.controller.Command;
	import com.soma.core.interfaces.ICommand;
	import com.soma.debugger.events.SomaDebuggerEvent;
	import com.soundstep.somacolor.controllers.events.ColorDataEvent;
	import com.soundstep.somacolor.controllers.events.ColorEvent;
	import com.soundstep.somacolor.wires.ColorWire;

	import flash.events.Event;

	/**
	 * <b>Author:</b> Romuald Quantin - <a href="http://www.soundstep.com/" target="_blank">www.soundstep.com</a><br />* <b>Class version:</b> 1.0<br />
	 * <b>Actionscript version:</b> 3.0<br />
	 * <b>Copyright:</b> 
	 * <br />
	 * <b>Date:</b> Sep 18, 2009<br />
	 * <b>Usage:</b>
	 * @example
	 * <listing version="3.0"></listing>
	 */
	
	public class StartCommand extends Command implements ICommand {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		

		//------------------------------------
		// public properties
		//------------------------------------
		
		
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		public function StartCommand() {
			
		}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		public function execute(event:Event):void {
			injector.createInstance(ColorWire, true);
			dispatchEvent(new ColorEvent(ColorDataEvent.LOAD));
			dispatchEvent(new SomaDebuggerEvent(SomaDebuggerEvent.MOVE_TO_TOP));
		}
	}
}