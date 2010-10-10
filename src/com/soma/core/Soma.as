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

package com.soma.core {
	import flash.events.IEventDispatcher;
	import com.soma.core.controller.SomaController;
	import com.soma.core.interfaces.IModel;
	import com.soma.core.interfaces.ISequenceCommand;
	import com.soma.core.interfaces.ISoma;
	import com.soma.core.interfaces.ISomaPlugin;
	import com.soma.core.interfaces.ISomaPluginVO;
	import com.soma.core.interfaces.IWire;
	import com.soma.core.model.SomaModels;
	import com.soma.core.view.SomaViews;
	import com.soma.core.wire.SomaWires;

	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;

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
	
	public class Soma extends EventDispatcher implements ISoma, IEventDispatcher {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		
		private var _models:SomaModels;
		private var _views:SomaViews;
		private var _controller:SomaController;
		private var _wires:SomaWires;
		
		private var _stage:Stage;

		//------------------------------------
		// public properties
		//------------------------------------
		
		
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		public function Soma(stage:Stage) {
			initialize(stage);
		}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		private function initialize(stage:Stage):void {
			validateStage(stage);
			_stage = stage;
			_models = new SomaModels(this);
			_views = new SomaViews();
			_controller = new SomaController(this);
			_wires = new SomaWires(this);
			registerModels();
			registerViews();
			registerCommands();
			registerWires();
			registerPlugins();
		}
		
		private function validateStage(stage:Stage):void {
			if (stage == null) throw new Error("Error in " + this + " You can't instantiate Soma with a stage that has a value null. Start soma after a Event.ADDED_TO_STAGE.");
		}
		
		protected function registerModels():void {
			
		}

		protected function registerViews():void {
			
		}

		protected function registerCommands():void {
			
		}

		protected function registerWires():void {
			
		}

		protected function registerPlugins():void {
			
		}
		
		//
		// PUBLIC
		//________________________________________________________________________________________________
		
		public function dispose():void {
			try {
				if (_models) { _models.dispose(); _models = null; }
				if (_views) { _views.dispose(); _views = null; }
				if (_controller) { _controller.dispose(); _controller = null; }
				if (_wires) { _wires.dispose(); _wires = null; }
				_stage = null;
			} catch(e:Error) {
				trace("Error in", this, "(dispose method):", e.message);
			}
		}

		public final function get models():SomaModels {
			return _models;
		}

		public final function get views():SomaViews {
			return _views;
		}

		public final function get controller():SomaController {
			return _controller;
		}

		public final function get wires():SomaWires {
			return _wires;
		}
		
		public final function createPlugin(plugin:Class, pluginVO:ISomaPluginVO):ISomaPlugin {
			var pluginInstance:Object = new plugin();
			if (!(pluginInstance is ISomaPlugin)) throw new Error("Error in " + this + " The plugin class must implements ISomaPlugin");
			ISomaPlugin(pluginInstance).initialize(pluginVO);
			return pluginInstance as ISomaPlugin;
		}

		public final function createPluginFromClassName(pluginClassName:String, pluginVO:ISomaPluginVO):ISomaPlugin {
			try {
				var PluginClass:Class = getDefinitionByName(pluginClassName) as Class;
				var pluginInstance:Object = new PluginClass();
				if (!(pluginInstance is ISomaPlugin)) throw new Error("Error in " + this + " The plugin class must implements ISomaPlugin");
				ISomaPlugin(pluginInstance).initialize(pluginVO);
				return pluginInstance as ISomaPlugin;
			} catch (e:Error) {
				if (e.errorID == 1065) throw new Error("Error in " + this + " Plugin From ClassName not created (" + pluginClassName + "), you need to import your Class or use the createPlugin() method.");
				else throw e;
			}
			return null;
		}

		public final function get stage():Stage {
			return _stage;
		}
		
		public final function hasCommand(commandName:String):Boolean {
			if (!controller) return false;
			return controller.hasCommand(commandName);
		}
		
		public final function addCommand(commandName:String, command:Class):void {
			if (!controller) return;
			controller.addCommand(commandName, command);
		}
		
		public final function removeCommand(commandName:String):void {
			if (!controller) return;
			controller.removeCommand(commandName);
		}
		
		public final function getCommand(commandName:String):Class {
			if (!controller) return null;
			return controller.getCommand(commandName);
		}
		
		public final function getCommands():Array {
			if (!controller) return null;
			return controller.getCommands();
		}
		
		public final function getSequencer(event:Event):ISequenceCommand {
			if (!controller) return null;
			return controller.getSequencer(event);
		}
		
		public final function stopSequencerWithEvent(event:Event):Boolean {
			if (!controller) return false;
			return controller.stopSequencerWithEvent(event);
		}
		
		public final function stopSequencer(sequencer:ISequenceCommand):Boolean {
			if (!controller) return false;
			return controller.stopSequencer(sequencer);
		}
		
		public final function getRunningSequencers():Array {
			if (!controller) return null;
			return controller.getRunningSequencers();
		}
		
		public final function stopAllSequencers():void {
			if (!controller) return;
			controller.stopAllSequencers();
		}
		
		public final function isPartOfASequence(event:Event):Boolean {
			if (!controller) return false;
			return controller.isPartOfASequence(event);
		}
		
		public final function getLastSequencer():ISequenceCommand {
			if (!controller) return null;
			return controller.getLastSequencer();
		}
		
		public final function hasModel(modelName:String):Boolean {
			if (!models) return false;
			return models.hasModel(modelName);
		}
		
		public final function addModel(modelName:String, model:IModel):IModel {
			if (!models) return null;
			return models.addModel(modelName, model);
		}
		
		public final function removeModel(modelName:String):void {
			if (!models) return;
			models.removeModel(modelName);
		}
		
		public final function getModel(modelName:String):IModel {
			if (!models) return null;
			return models.getModel(modelName);
		}
		
		public final function getModels():Dictionary {
			if (!models) return null;
			return models.getModels();
		}
		
		public final function hasView(viewName:String):Boolean {
			if (!views) return false;
			return views.hasView(viewName);
		}
		
		public final function addView(viewName:String, view:Object):Object {
			if (!views) return null;
			return views.addView(viewName, view);
		}
		
		public final function removeView(viewName:String):void {
			if (!views) return;
			views.removeView(viewName);
		}
		
		public final function getView(viewName:String):Object {
			if (!views) return null;
			return views.getView(viewName);
		}
		
		public final function getViews():Dictionary {
			if (!views) return null;
			return views.getViews();
		}
		
		public final function hasWire(wireName:String):Boolean {
			if (!wires) return false;
			return wires.hasWire(wireName);
		}
		
		public final function addWire(wireName:String, wire:IWire):IWire {
			if (!wires) return null;
			return wires.addWire(wireName, wire);
		}
		
		public final function removeWire(wireName:String):void {
			if (!wires) return;
			wires.removeWire(wireName);
		}
		
		public final function getWire(wireName:String):IWire {
			if (!wires) return null;
			return wires.getWire(wireName);
		}
		
		public final function getWires():Dictionary {
			if (!wires) return null;
			return wires.getWires();
		}
		
	}
}