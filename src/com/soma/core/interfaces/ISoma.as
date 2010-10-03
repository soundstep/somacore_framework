package com.soma.core.interfaces {
	import com.soma.core.controller.SomaController;
	import com.soma.core.model.SomaModels;
	import com.soma.core.view.SomaViews;
	import com.soma.core.wire.SomaWires;

	import flash.display.Stage;
	import flash.events.Event;
	import flash.utils.Dictionary;

	/**
	 * <b>Author:</b> Romuald Quantin - <a href="http://www.soundstep.com/" target="_blank">www.soundstep.com</a><br />* <b>Class version:</b> 1.0<br />
	 * <b>Actionscript version:</b> 3.0<br />
	 * <b>Copyright:</b> 
	 * <br />
	 * <b>Date:</b> Sep 17, 2009<br />
	 * <b>Usage:</b>
	 * @example
	 * <listing version="3.0"></listing>
	 */
	
	public interface ISoma {
		
		function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void;
		function dispatchEvent(event:Event):Boolean;
		function hasEventListener(type:String):Boolean;
		function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void;
		function willTrigger(type:String):Boolean;
		
		function get stage():Stage;
		
		function get models():SomaModels;
		function get views():SomaViews;
		function get controller():SomaController;
		function get wires():SomaWires;
		
		function createPlugin(plugin:Class, pluginVO:ISomaPluginVO):ISomaPlugin;
		
		function dispose():void;
		
		function hasCommand(commandName:String):Boolean;
		function addCommand(commandName:String, command:Class):void;
		function removeCommand(commandName:String):void;
		function getCommand(commandName:String):Class;
		function getCommands():Array;
		
		function getSequencer(event:Event):ISequenceCommand;
		function stopSequencerWithEvent(event:Event):Boolean;
		function stopSequencer(sequencer:ISequenceCommand):Boolean;
		function getRunningSequencers():Array;
		function stopAllSequencers():void;
		function isPartOfASequence(event:Event):Boolean;
		function getLastSequencer():ISequenceCommand;
		
		function hasModel(modelName:String):Boolean;
		function addModel(modelName:String, model:IModel):IModel;
		function removeModel(modelName:String):void;
		function getModel(modelName:String):IModel;
		function getModels():Dictionary;
		
		function hasView(viewName:String):Boolean;
		function addView(viewName:String, view:Object):Object;
		function removeView(viewName:String):void;
		function getView(viewName:String):Object;
		function getViews():Dictionary;
		
		function hasWire(wireName:String):Boolean;
		function addWire(wireName:String, wire:IWire):IWire;
		function removeWire(wireName:String):void;
		function getWire(wireName:String):IWire;
		function getWires():Dictionary;
		
	}
}