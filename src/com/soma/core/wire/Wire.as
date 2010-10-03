package com.soma.core.wire {
	import com.soma.core.interfaces.IModel;
	import com.soma.core.interfaces.ISequenceCommand;
	import com.soma.core.interfaces.ISoma;
	import com.soma.core.interfaces.IWire;

	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
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
	
	public class Wire implements IEventDispatcher {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		namespace somans = "http://www.soundstep.com/soma";
		
		private var _instance:ISoma;
		protected var _name:String;

		//------------------------------------
		// public final properties
		//------------------------------------
		
		public static var NAME:String = "Soma::Wire";
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		public final function Wire(name:String = null) {
			if (name != "" && name != null) _name = name;
		}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		protected function initialize():void {
			
		}
		
		protected function dispose():void {
			
		}
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		somans function registerInstance(instance:ISoma):void {
			_instance = instance;
			initialize();
		}
		
		somans function dispose():void {
			dispose();
		}
		
		public final function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void {
			soma.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}

		public final function dispatchEvent(event:Event):Boolean {
			return soma.dispatchEvent(event);
		}
		
		public final function hasEventListener(type:String):Boolean {
			return soma.hasEventListener(type);
		}
		
		public final function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void {
			soma.removeEventListener(type, listener, useCapture);
		}

		public final function willTrigger(type:String):Boolean {
			return soma.willTrigger(type);
		}
		
		public final function get soma():ISoma {
			return _instance;
		}
		
		public final function get stage():Stage {
			return soma.stage;
		}
		
		public final function getName():String {
			return _name;
		}
		
		public final function setName(name:String):void {
			_name = name;
		}
		
		public final function hasCommand(commandName:String):Boolean {
			if (!soma.controller) return false;
			return soma.controller.hasCommand(commandName);
		}
		
		public final function addCommand(commandName:String, command:Class):void {
			if (!soma.controller) return;
			soma.controller.addCommand(commandName, command);
		}
		
		public final function removeCommand(commandName:String):void {
			if (!soma.controller) return;
			soma.controller.removeCommand(commandName);
		}
		
		public final function getCommand(commandName:String):Class {
			if (!soma.controller) return null;
			return soma.controller.getCommand(commandName);
		}
		
		public final function getCommands():Array {
			if (!soma.controller) return null;
			return soma.controller.getCommands();
		}
		
		public final function getSequencer(event:Event):ISequenceCommand {
			if (!soma.controller) return null;
			return soma.controller.getSequencer(event);
		}
		
		public final function stopSequencerWithEvent(event:Event):Boolean {
			if (!soma.controller) return false;
			return soma.controller.stopSequencerWithEvent(event);
		}
		
		public final function stopSequencer(sequencer:ISequenceCommand):Boolean {
			if (!soma.controller) return false;
			return soma.controller.stopSequencer(sequencer);
		}
		
		public final function getRunningSequencers():Array {
			if (!soma.controller) return null;
			return soma.controller.getRunningSequencers();
		}
		
		public final function stopAllSequencers():void {
			if (!soma.controller) return;
			soma.controller.stopAllSequencers();
		}
		
		public final function isPartOfASequence(event:Event):Boolean {
			if (!soma.controller) return false;
			return soma.controller.isPartOfASequence(event);
		}
		
		public final function getLastSequencer():ISequenceCommand {
			if (!soma.controller) return null;
			return soma.controller.getLastSequencer();
		}
		
		public final function hasModel(modelName:String):Boolean {
			if (!soma.models) return false;
			return soma.models.hasModel(modelName);
		}
		
		public final function addModel(modelName:String, model:IModel):IModel {
			if (!soma.models) return null;
			return soma.models.addModel(modelName, model);
		}
		
		public final function removeModel(modelName:String):void {
			if (!soma.models) return;
			soma.models.removeModel(modelName);
		}
		
		public final function getModel(modelName:String):IModel {
			if (!soma.models) return null;
			return soma.models.getModel(modelName);
		}
		
		public final function getModels():Dictionary {
			if (!soma.models) return null;
			return soma.models.getModels();
		}
		
		public final function hasView(viewName:String):Boolean {
			if (!soma.views) return false;
			return soma.views.hasView(viewName);
		}
		
		public final function addView(viewName:String, view:Object):Object {
			if (!soma.views) return null;
			return soma.views.addView(viewName, view);
		}
		
		public final function removeView(viewName:String):void {
			if (!soma.views) return;
			soma.views.removeView(viewName);
		}
		
		public final function getView(viewName:String):Object {
			if (!soma.views) return null;
			return soma.views.getView(viewName);
		}
		
		public final function getViews():Dictionary {
			if (!soma.views) return null;
			return soma.views.getViews();
		}
		
		public final function hasWire(wireName:String):Boolean {
			if (!soma.wires) return false;
			return soma.wires.hasWire(wireName);
		}
		
		public final function addWire(wireName:String, wire:IWire):IWire {
			if (!soma.wires) return null;
			return soma.wires.addWire(wireName, wire);
		}
		
		public final function removeWire(wireName:String):void {
			if (!soma.wires) return;
			soma.wires.removeWire(wireName);
		}
		
		public final function getWire(wireName:String):IWire {
			if (!soma.wires) return null;
			return soma.wires.getWire(wireName);
		}
		
		public final function getWires():Dictionary {
			if (!soma.wires) return null;
			return soma.wires.getWires();
		}
		
	}
}