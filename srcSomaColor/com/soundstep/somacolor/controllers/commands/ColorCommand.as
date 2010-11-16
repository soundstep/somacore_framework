package com.soundstep.somacolor.controllers.commands {
	import com.soma.core.controller.Command;
	import com.soma.core.interfaces.ICommand;
	import com.soma.core.interfaces.ISequenceCommand;
	import com.soundstep.somacolor.SomaApplication;
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
	
	public class ColorCommand extends Command implements ICommand {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		

		//------------------------------------
		// public properties
		//------------------------------------
		
		[Inject]
		public var wire:ColorWire;
		
		[Inject]
		public var sequencer:ISequenceCommand;
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		public function ColorCommand() {
			
		}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		public function execute(event:Event):void {
			switch (event.type) {
				case ColorDataEvent.LOAD:
					wire.loadColorData();
					break;
				case ColorDataEvent.UPDATED:
					wire.updateViews();
					break;
				case ColorEvent.CHANGE_COLOR:
					wire.updateReceiverColor(ColorEvent(event).color);
					wire.updateSquareColor(ColorEvent(event).color);
					break;
			}
			
			if (isPartOfASequence(event)) {
				SomaApplication(instance).debug("Sequence continue, " + sequencer.length + " left!");
				sequencer.executeNextCommand();
			}
		}
	}
}