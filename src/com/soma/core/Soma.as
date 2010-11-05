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

	import com.soma.core.mediator.SomaMediators;
	import com.soma.core.controller.SomaController;
	import com.soma.core.di.SomaInjector;
	import com.soma.core.interfaces.IModel;
	import com.soma.core.interfaces.ISequenceCommand;
	import com.soma.core.interfaces.ISoma;
	import com.soma.core.interfaces.ISomaInjector;
	import com.soma.core.interfaces.ISomaPlugin;
	import com.soma.core.interfaces.ISomaPluginVO;
	import com.soma.core.interfaces.IWire;
	import com.soma.core.model.SomaModels;
	import com.soma.core.view.SomaViews;
	import com.soma.core.wire.SomaWires;

	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;

	/**
	 * <p><b>Author:</b> Romuald Quantin - <a href="http://www.soundstep.com/" target="_blank">www.soundstep.com</a></p>
	 * <p><b>Resources:</b> <a href="http://www.soundstep.com/downloads/somacore" target="_blank">http://www.soundstep.com/downloads/somacore</a></p>
	 * <p><b>Class version:</b> v1.0.0</p>
	 * <p><b>Actionscript version:</b> 3.0</p>
	 * <p><b>Copyright:</b>
	 * Mozilla Public License 1.1 (MPL 1.1)<br /> 
	 * <a href="http://www.opensource.org/licenses/mozilla1.1.php" target="_blank">http://www.opensource.org/licenses/mozilla1.1.php</a></p>
	 * <p>SomaCore is a lightweight event-based MVC framework written in AS3 that provides a structure, models, views management and commands.
	 * Somacore can be used for Flash, Flex and AIR projects. SomaCore does not use any external library and does not use dependency injection. SomaCore is completely event-based and use a concept of wires to code in a efficient decoupled way.
	 * You can use SomaCore in anything, except to include/distribute it in another framework, application, template, component or structure that is meant to build, scaffold or generate source files.</p>
	 * <p>Few things to know: SomaCore requires the stage to be instantiated. Commands are normal built-in Flash events with the bubbles property set to true. Commands can be used in the views as they are not really framework code.
	 * Wires are the glue of the frameworks elements (models, commands, views, wires) and can be used the way you wish, as proxy/mediators or managers.
	 * Wires can manage one class or multiple classes.
	 * Parallel and sequence commands are built-in.
	 * You can create and register customs plugins to the framework (such as the SomaDebugger plugin).
	 * You can access to all the framework elements that you have registered (stage, framework instance, wires, models, views and commands) from commands and wires. 
	 * </p>
	 * @example
	 * To get started, create a instance of a class that extends the Soma class and implements the ISoma interface.
	 * <listing version="3.0">
package  {
	import com.soma.core.interfaces.ISoma;
	import flash.display.Sprite;
	
	public class Main extends Sprite {
		
		private var _app:ISoma;
		
		public function Main() {
			_app = new SomaApplication(stage);
		}
		
	}
}
	 * </listing>
	 * <listing version="3.0">
package  {
	import com.soma.core.Soma;
	import com.soma.core.interfaces.ISoma;
	import flash.display.Stage;
	
	public class SomaApplication extends Soma implements ISoma {

		public function SomaApplication(stage:Stage) {
			super(stage);
		}
		
		override protected function registerCommands():void {
			
		}

		override protected function registerModels():void {
			
		}

		override protected function registerPlugins():void {
			
		}

		override protected function registerViews():void {
			
		}

		override protected function registerWires():void {
			
		}
		
	}
}
	 * </listing>
	 * 
	 */
	
	public class Soma extends EventDispatcher implements ISoma, IEventDispatcher {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		/** @private */
		protected var _models:SomaModels;
		/** @private */
		private var _views:SomaViews;
		/** @private */
		protected var _controller:SomaController;
		/** @private */
		protected var _wires:SomaWires;
		/** @private */
		protected var _stage:Stage;
		
		protected var _injector:ISomaInjector;
		protected var _mediators:SomaMediators;

		//------------------------------------
		// public properties
		//------------------------------------
		
		
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		/**
		 * Create an instance of the SomaCore class.
		 * @param stage The stage is used as a global EventDispatcher (as well as the Soma class), and is required to instantiate the framework.
		 */
		public function Soma(stage:Stage) {
			initializeApplication(stage);
		}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		/** @private */
		private function initializeApplication(stage:Stage):void {
			validateStage(stage);
			_stage = stage;
			initializeInjector();
			initializeCore();
			registerModels();
			registerViews();
			registerCommands();
			registerWires();
			registerPlugins();
		}

		/** @private */
		private function validateStage(stage:Stage):void {
			if (stage == null) throw new Error("Error in " + this + " You can't instantiate Soma with a stage that has a value null. Start soma after a Event.ADDED_TO_STAGE.");
		}
		
		/** @private */
		protected function initializeCore():void {
			_models = new SomaModels(this);
			_views = new SomaViews();
			_controller = new SomaController(this);
			_wires = new SomaWires(this);
			_mediators = new SomaMediators(this);
		}
		
		protected function initializeInjector():void {
			_injector = new SomaInjector() as ISomaInjector;
		}
		
		/** 
		 * Method that you can optionally overwrite to register models to the framework.
		 * @see com.soma.core.model.SomaModels
		 * @example
		 * <listing version="3.0">addModel(MyModel.NAME, new MyModel());</listing>
		 */
		protected function registerModels():void {
			
		}
		
		/** 
		 * Method that you can optionally overwrite to register views to the framework.
		 * @see com.soma.core.view.SomaViews
		 * @example
		 * <listing version="3.0">addView(MySprite.NAME, new MySprite());</listing>
		 */
		protected function registerViews():void {
			
		}
		
		/** 
		 * Method that you can optionally overwrite to register commands (mapping events to command classes) to the framework.
		 * @see com.soma.core.controller.SomaController
		 * @example
		 * <listing version="3.0">addCommand(MyEvent.DOSOMETING, MyCommandClass);</listing>
		 */
		protected function registerCommands():void {
			
		}
		
		/** 
		 * Method that you can optionally overwrite to register wires to the framework.
		 * @see com.soma.core.wire.SomaWires
		 * @example
		 * <listing version="3.0">addWire(MyWire.NAME, new MyWire());</listing>
		 */
		protected function registerWires():void {
			
		}
		
		/** 
		 * Method that you can optionally overwrite to register plugins to the framework.
		 * @example
		 * <listing version="3.0">
var pluginVO:SomaDebuggerVO = new SomaDebuggerVO(this, SomaDebugger.NAME_DEFAULT, getCommands(), true, false);
var debugger:SomaDebugger = createPlugin(SomaDebugger, pluginVO) as SomaDebugger;
		 * </listing>
		 */
		protected function registerPlugins():void {
			
		}
		
		//
		// PUBLIC
		//________________________________________________________________________________________________
		
		/**
		 * Destroys the SomaCore core classes and elements registered to the framework.
		 */
		public function dispose():void {
			try {
				if (_models) { _models.dispose(); _models = null; }
				if (_views) { _views.dispose(); _views = null; }
				if (_controller) { _controller.dispose(); _controller = null; }
				if (_wires) { _wires.dispose(); _wires = null; }
				if (_mediators) { _mediators.dispose(); _mediators = null; }
				if (_injector) _injector = null;
				_stage = null;
			} catch(e:Error) {
				trace("Error in", this, "(dispose method):", e.message);
			}
		}
		
		/**
		 * Gets the model manager class.
		 */
		public final function get models():SomaModels {
			return _models;
		}

		/**
		 * Gets the view manager class.
		 */
		public final function get views():SomaViews {
			return _views;
		}

		/**
		 * Gets the commands manager class.
		 */
		public final function get controller():SomaController {
			return _controller;
		}

		/**
		 * Gets the wires manager class.
		 */
		public final function get wires():SomaWires {
			return _wires;
		}
		
		/**
		 * Creates a plugin instance.
		 * @param plugin Class of the plugin that will be instantiated.
		 * @param pluginVO Value Object class of the plugin.
		 * @return An instance of the plugin.
		 * @example
		 * <listing version="3.0">
var pluginVO:SomaDebuggerVO = new SomaDebuggerVO(this, SomaDebugger.NAME_DEFAULT, getCommands(), true, false);
var debugger:SomaDebugger = createPlugin(SomaDebugger, pluginVO) as SomaDebugger;
		 * </listing>
		 */
		public final function createPlugin(plugin:Class, pluginVO:ISomaPluginVO):ISomaPlugin {
			var pluginInstance:Object = new plugin();
			if (!(pluginInstance is ISomaPlugin)) throw new Error("Error in " + this + " The plugin class must implements ISomaPlugin");
			ISomaPlugin(pluginInstance).initialize(pluginVO);
			return pluginInstance as ISomaPlugin;
		}

		/**
		 * Creates a plugin instance using the class name and the getDefinitionByName method.
		 * @param plugin Class name of the plugin that will be instantiated.
		 * @param pluginVO Value Object class of the plugin.
		 * @return An instance of the plugin.
		 * @example
		 * <listing version="3.0">
var pluginVO:SomaDebuggerVO = new SomaDebuggerVO(this, SomaDebugger.NAME_DEFAULT, getCommands(), true, false);
var debugger:SomaDebugger = createPluginFromClassName("com.soma.core.debugger.SomaDebugger", pluginVO) as SomaDebugger;
		 * </listing>
		 */
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
		
		/**
		 * Get the stage that has been registered to the framework.
		 * @return The stage instance.
		 */
		public final function get stage():Stage {
			return _stage;
		}
		
		/**
		 * Indicates wether a command has been registered to the framework.
		 * @param commandName Event type that is used as a command name.
		 * @return A Boolean.
		 * @see com.soma.core.controller.SomaController
		 * @example
		 * <listing version="3.0">hasCommand(MyEvent.DOSOMETHING);</listing>
		 */
		public final function hasCommand(commandName:String):Boolean {
			if (!controller) return false;
			return controller.hasCommand(commandName);
		}
		
		/**
		 * Registers a command to the framework.
		 * @param commandName Event type that is used as a command name.
		 * @param command Class that will be executed when a command has been dispatched.
		 * @see com.soma.core.controller.SomaController
		 * @example
		 * <listing version="3.0">addCommand(MyEvent.DOSOMETHING, MyCommand);</listing>
		 */
		public final function addCommand(commandName:String, command:Class):void {
			if (!controller) return;
			controller.addCommand(commandName, command);
		}
		
		/**
		 * Removes a command from the framework.
		 * @param commandName Event type that is used as a command name.
		 * @see com.soma.core.controller.SomaController
		 * @example
		 * <listing version="3.0">removeCommand(MyEvent.DOSOMETHING);</listing>
		 */
		public final function removeCommand(commandName:String):void {
			if (!controller) return;
			controller.removeCommand(commandName);
		}
		
		/**
		 * Retrieves the command class that has been registered with a command name.
		 * @param commandName Event type that is used as a command name.
		 * @return A class.
		 * @see com.soma.core.controller.SomaController
		 * @example
		 * <listing version="3.0">var commandClass:ICommand = getCommand(MyEvent.DOSOMETHING) as ICommand;</listing>
		 */
		public final function getCommand(commandName:String):Class {
			if (!controller) return null;
			return controller.getCommand(commandName);
		}
		
		/**
		 * Retrieves all the command names (event type) that have been registered to the framework.
		 * @return An Array of String (command name).
		 * @see com.soma.core.controller.SomaController
		 * @example
		 * <listing version="3.0">var commands:Array = getCommands();</listing>
		 */
		public final function getCommands():Array {
			if (!controller) return null;
			return controller.getCommands();
		}
		
		/**
		 * Retrieves the sequence command instance using an event instance that has been created from this sequence command.
		 * @param event Event instance.
		 * @return A sequencer (ISequenceCommand).
		 * @see com.soma.core.controller.SomaController
		 * @example
		 * <listing version="3.0">var sequencer:ISequenceCommand = getSequencer(myEvent);</listing>
		 */
		public final function getSequencer(event:Event):ISequenceCommand {
			if (!controller) return null;
			return controller.getSequencer(event);
		}
		
		/**
		 * Stops a sequence command using an event instance that has been created from this sequence command.
		 * @param event Event instance.
		 * @return A Boolean (true if a sequence command has been stopped).
		 * @see com.soma.core.controller.SomaController
		 * @example
		 * <listing version="3.0">var success:Boolean = stopSequencerWithEvent(myEvent);</listing>
		 */
		public final function stopSequencerWithEvent(event:Event):Boolean {
			if (!controller) return false;
			return controller.stopSequencerWithEvent(event);
		}
		
		/**
		 * Stops a sequence command using the sequence command instance itself.
		 * @param sequencer The sequence command instance.
		 * @return A Boolean (true if the sequence command has been stopped).
		 * @see com.soma.core.controller.SomaController
		 * @example
		 * <listing version="3.0">var success:Boolean = stopSequencer(mySequenceCommand);</listing>
		 */
		public final function stopSequencer(sequencer:ISequenceCommand):Boolean {
			if (!controller) return false;
			return controller.stopSequencer(sequencer);
		}
		
		/**
		 * Retrieves all the sequence command instances that are running.
		 * @return An Array of ISequenceCommand instances.
		 * @see com.soma.core.controller.SomaController
		 * @example
		 * <listing version="3.0">var sequencers:Array = getRunningSequencers();</listing>
		 */
		public final function getRunningSequencers():Array {
			if (!controller) return null;
			return controller.getRunningSequencers();
		}
		
		/**
		 * Stops all the sequence command instances that are running.
		 * @see com.soma.core.controller.SomaController
		 * @example
		 * <listing version="3.0">stopAllSequencers();</listing>
		 */
		public final function stopAllSequencers():void {
			if (!controller) return;
			controller.stopAllSequencers();
		}
		
		/**
		 * Indicates wether an event has been instantiated from a ISequenceCommand class.
		 * @return A Boolean.
		 * @see com.soma.core.controller.SomaController
		 * @example
		 * <listing version="3.0">var inSequence:Boolean = isPartOfASequence(myEvent);</listing>
		 */
		public final function isPartOfASequence(event:Event):Boolean {
			if (!controller) return false;
			return controller.isPartOfASequence(event);
		}
		
		/**
		 * Retrieves the last sequence command that has been instantiated in the framework.
		 * @return An ISequenceCommand instance.
		 * @see com.soma.core.controller.SomaController
		 * @example
		 * <listing version="3.0">var lastSequencer:ISequenceCommand = getLastSequencer();</listing>
		 */
		public final function getLastSequencer():ISequenceCommand {
			if (!controller) return null;
			return controller.getLastSequencer();
		}
		
		/**
		 * Indicates wether a model has been registered to the framework.
		 * @param modelName Name of the model.
		 * @return A Boolean.
		 * @see com.soma.core.model.SomaModels
		 * @example
		 * <listing version="3.0">hasModel(MyModel.NAME);</listing>
		 */
		public final function hasModel(modelName:String):Boolean {
			if (!models) return false;
			return models.hasModel(modelName);
		}
		
		/**
		 * Registers a model to the framework.
		 * @param modelName Name of the model.
		 * @param model Instance of the model.
		 * @return The model instance.
		 * @see com.soma.core.model.SomaModels
		 * @example
		 * <listing version="3.0">addModel(MyModel.NAME, new MyModel());</listing>
		 */
		public final function addModel(modelName:String, model:IModel):IModel {
			if (!models) return null;
			return models.addModel(modelName, model);
		}
		
		/**
		 * Removes a model from the framework and call the dispose method of this model.
		 * @param modelName Name of the model.
		 * @see com.soma.core.model.SomaModels
		 * @example
		 * <listing version="3.0">removeModel(MyModel.NAME);</listing>
		 */
		public final function removeModel(modelName:String):void {
			if (!models) return;
			models.removeModel(modelName);
		}
		
		/**
		 * Retrieves the model instance that has been registered using its name.
		 * @param modelName Name of the model.
		 * @return A IModel instance.
		 * @see com.soma.core.model.SomaModels
		 * @example
		 * <listing version="3.0">var myModel:MyModel = getModel(MyModel.NAME) as MyModel;</listing>
		 */
		public final function getModel(modelName:String):IModel {
			if (!models) return null;
			return models.getModel(modelName);
		}
		
		/**
		 * Retrieves all the model instances that have been registered to the framework.
		 * @return A Dictionary (the key of the Dictionary is the name used for the registration).
		 * @see com.soma.core.model.SomaModels
		 * @example
		 * <listing version="3.0">var models:Dictionary = getModels();</listing>
		 */
		public final function getModels():Dictionary {
			if (!models) return null;
			return models.getModels();
		}
		
		/**
		 * Indicates wether a view has been registered to the framework.
		 * @param viewName Name of the view.
		 * @return A Boolean.
		 * @see com.soma.core.view.SomaViews
		 * @example
		 * <listing version="3.0">hasView(MySprite.NAME);</listing>
		 */
		public final function hasView(viewName:String):Boolean {
			if (!views) return false;
			return views.hasView(viewName);
		}
		
		/**
		 * Registers a view to the framework.
		 * @param viewName Name of the view.
		 * @param view Instance of the view.
		 * @return The view instance.
		 * @see com.soma.core.view.SomaViews
		 * @example
		 * <listing version="3.0">addView(MySprite.NAME, new MySprite());</listing>
		 */
		public final function addView(viewName:String, view:Object):Object {
			if (!views) return null;
			return views.addView(viewName, view);
		}
		
		/**
		 * Removes a view from the framework and call the (optional) dispose method of this view.
		 * @param viewName Name of the view.
		 * @see com.soma.core.view.SomaViews
		 * @example
		 * <listing version="3.0">removeView(MySprite.NAME);</listing>
		 */
		public final function removeView(viewName:String):void {
			if (!views) return;
			views.removeView(viewName);
		}
		
		/**
		 * Retrieves the view instance that has been registered using its name.
		 * @param viewName Name of the view.
		 * @return An Object instance.
		 * @see com.soma.core.view.SomaViews
		 * @example
		 * <listing version="3.0">var mySprite:MySprite = getView(MySprite.NAME) as MySprite;</listing>
		 */
		public final function getView(viewName:String):Object {
			if (!views) return null;
			return views.getView(viewName);
		}
		
		/**
		 * Retrieves all the view instances that have been registered to the framework.
		 * @return A Dictionary (the key of the Dictionary is the name used for the registration).
		 * @see com.soma.core.view.SomaViews
		 * @example
		 * <listing version="3.0">var sprites:Dictionary = getViews();</listing>
		 */
		public final function getViews():Dictionary {
			if (!views) return null;
			return views.getViews();
		}
		
		/**
		 * Indicates wether a wire has been registered to the framework.
		 * @param wireName Name of the wire.
		 * @return A Boolean.
		 * @see com.soma.core.wire.SomaWires
		 * @example
		 * <listing version="3.0">hasWire(MyWire.NAME);</listing>
		 */
		public final function hasWire(wireName:String):Boolean {
			if (!wires) return false;
			return wires.hasWire(wireName);
		}
		
		/**
		 * Registers a wire to the framework.
		 * @param wireName Name of the wire.
		 * @param view Instance of the wire.
		 * @return The wire instance.
		 * @see com.soma.core.wire.SomaWires
		 * @example
		 * <listing version="3.0">addWire(MyWire.NAME, new MyWire());</listing>
		 */
		public final function addWire(wireName:String, wire:IWire):IWire {
			if (!wires) return null;
			return wires.addWire(wireName, wire);
		}
		
		/**
		 * Removes a wire from the framework and call the dispose method of this wire.
		 * @param wireName Name of the wire.
		 * @see com.soma.core.wire.SomaWires
		 * @example
		 * <listing version="3.0">removeWire(MyWire.NAME);</listing>
		 */
		public final function removeWire(wireName:String):void {
			if (!wires) return;
			wires.removeWire(wireName);
		}
		
		/**
		 * Retrieves the wire instance that has been registered using its name.
		 * @param wireName Name of the wire.
		 * @return A wire instance.
		 * @see com.soma.core.wire.SomaWires
		 * @example
		 * <listing version="3.0">var myWire:MyWire = getWire(MyWire.NAME) as MyWire;</listing>
		 */
		public final function getWire(wireName:String):IWire {
			if (!wires) return null;
			return wires.getWire(wireName);
		}
		
		/**
		 * Retrieves all the wire instances that have been registered to the framework.
		 * @return A Dictionary (the key of the Dictionary is the name used for the registration).
		 * @see com.soma.core.wire.SomaWires
		 * @example
		 * <listing version="3.0">var wires:Dictionary = getWires();</listing>
		 */
		public final function getWires():Dictionary {
			if (!wires) return null;
			return wires.getWires();
		}

		public function get injector():ISomaInjector {
			return _injector;
		}
		
		public function get mediators():SomaMediators {
			return _mediators;
		}
		
	}
}