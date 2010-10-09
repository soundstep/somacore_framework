/**
 * The contents of this file are subject to the Mozilla Public License
 * Version 1.1 (the "License"); you may not use this file except in compliance
 * with the License. You may obtain a copy of the License at
 * 
 * http://www.mozilla.org/MPL/
 * 
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied.
 * See the License for the specific language governing rights and
 * limitations under the License.
 * 
 * The Original Code is SomaCore.
 * 
 * The Initial Developer of the Original Code is Romuald Quantin.
 * romu@soundstep.com (www.soundstep.com).
 * 
 * Portions created by
 * 
 * Initial Developer are Copyright (C) 2008-2010 Soundstep. All Rights Reserved.
 * All Rights Reserved.
 * 
 */

package com.soma.core.controller {
	import com.soma.core.ns.somans;
	import com.soma.core.interfaces.IModel;
	import com.soma.core.interfaces.ISequenceCommand;
	import com.soma.core.interfaces.ISoma;
	import com.soma.core.interfaces.IWire;

	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.utils.Dictionary;

	/**
	 * <b>Author:</b> Romuald Quantin - <a href="http://www.soundstep.com/" target="_blank">www.soundstep.com</a><br />
	 * <b>Class version:</b> v1.0.0<br />
	 * <b>Actionscript version:</b> 3.0<br />
	 * <b>Copyright:</b>
	 * Mozilla Public License 1.1 (MPL 1.1)<br /> 
	 * <a href="http://www.opensource.org/licenses/mozilla1.1.php" target="_blank">http://www.opensource.org/licenses/mozilla1.1.php</a><br />
	 * You can use SomaCore in anything, except to include/distribute it in another framework, application, template, component or structure that is meant to build, scaffold or generate source files.<br />
	 * <br />
	 * <b>Usage:</b><br />
	 * @example
	 * <listing version="3.0">
	 * </listing>
	 */
	
	public class Command implements IEventDispatcher {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		private var _instance:ISoma;

		//------------------------------------
		// public properties
		//------------------------------------
		
		
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		public function Command() {
			
		}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		protected function initialize():void {
			
		}
		
		//
		// PUBLIC
		//________________________________________________________________________________________________
		
		somans function registerInstance(instance:ISoma):void {
			_instance = instance;
			initialize();
		}
		
		public final function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void {
			_instance.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}

		public final function dispatchEvent(event:Event):Boolean {
			return _instance.dispatchEvent(event);
		}
		
		public final function hasEventListener(type:String):Boolean {
			return _instance.hasEventListener(type);
		}
		
		public final function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void {
			_instance.removeEventListener(type, listener, useCapture);
		}

		public final function willTrigger(type:String):Boolean {
			return _instance.willTrigger(type);
		}
		
		public final function get instance():ISoma {
			return _instance;
		}
		
		public final function get stage():Stage {
			return _instance.stage;
		}
		
		public final function hasCommand(commandName:String):Boolean {
			if (!_instance.controller) return false;
			return _instance.controller.hasCommand(commandName);
		}
		
		public final function addCommand(commandName:String, command:Class):void {
			if (!_instance.controller) return;
			_instance.controller.addCommand(commandName, command);
		}
		
		public final function removeCommand(commandName:String):void {
			if (!_instance.controller) return;
			_instance.controller.removeCommand(commandName);
		}
		
		public final function getCommand(commandName:String):Class {
			if (!_instance.controller) return null;
			return _instance.controller.getCommand(commandName);
		}
		
		public final function getCommands():Array {
			if (!_instance.controller) return null;
			return _instance.controller.getCommands();
		}
		
		public final function getSequencer(event:Event):ISequenceCommand {
			if (!_instance.controller) return null;
			return _instance.controller.getSequencer(event);
		}
		
		public final function stopSequencerWithEvent(event:Event):Boolean {
			if (!_instance.controller) return false;
			return _instance.controller.stopSequencerWithEvent(event);
		}
		
		public final function stopSequencer(sequencer:ISequenceCommand):Boolean {
			if (!_instance.controller) return false;
			return _instance.controller.stopSequencer(sequencer);
		}
		
		public final function getRunningSequencers():Array {
			if (!_instance.controller) return null;
			return _instance.controller.getRunningSequencers();
		}
		
		public final function stopAllSequencers():void {
			if (!_instance.controller) return;
			_instance.controller.stopAllSequencers();
		}
		
		public final function isPartOfASequence(event:Event):Boolean {
			if (!_instance.controller) return false;
			return _instance.controller.isPartOfASequence(event);
		}
		
		public final function getLastSequencer():ISequenceCommand {
			if (!_instance.controller) return null;
			return _instance.controller.getLastSequencer();
		}
		
		public final function hasModel(modelName:String):Boolean {
			if (!_instance.models) return false;
			return _instance.models.hasModel(modelName);
		}
		
		public final function addModel(modelName:String, model:IModel):IModel {
			if (!_instance.models) return null;
			return _instance.models.addModel(modelName, model);
		}
		
		public final function removeModel(modelName:String):void {
			if (!_instance.models) return;
			_instance.models.removeModel(modelName);
		}
		
		public final function getModel(modelName:String):IModel {
			if (!_instance.models) return null;
			return _instance.models.getModel(modelName);
		}
		
		public final function getModels():Dictionary {
			if (!_instance.models) return null;
			return _instance.models.getModels();
		}
		
		public final function hasView(viewName:String):Boolean {
			if (!_instance.views) return false;
			return _instance.views.hasView(viewName);
		}
		
		public final function addView(viewName:String, view:Object):Object {
			if (!_instance.views) return null;
			return _instance.views.addView(viewName, view);
		}
		
		public final function removeView(viewName:String):void {
			if (!_instance.views) return;
			_instance.views.removeView(viewName);
		}
		
		public final function getView(viewName:String):Object {
			if (!_instance.views) return null;
			return _instance.views.getView(viewName);
		}
		
		public final function getViews():Dictionary {
			if (!_instance.views) return null;
			return _instance.views.getViews();
		}
		
		public final function hasWire(wireName:String):Boolean {
			if (!_instance.wires) return false;
			return _instance.wires.hasWire(wireName);
		}
		
		public final function addWire(wireName:String, wire:IWire):IWire {
			if (!_instance.wires) return null;
			return _instance.wires.addWire(wireName, wire);
		}
		
		public final function removeWire(wireName:String):void {
			if (!_instance.wires) return;
			_instance.wires.removeWire(wireName);
		}
		
		public final function getWire(wireName:String):IWire {
			if (!_instance.wires) return null;
			return _instance.wires.getWire(wireName);
		}
		
		public final function getWires():Dictionary {
			if (!_instance.wires) return null;
			return _instance.wires.getWires();
		}
		
	}
}