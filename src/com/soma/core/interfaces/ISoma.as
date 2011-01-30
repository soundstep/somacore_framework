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

package com.soma.core.interfaces {

	import com.soma.core.controller.SomaController;
	import com.soma.core.mediator.SomaMediators;
	import com.soma.core.model.SomaModels;
	import com.soma.core.view.SomaViews;
	import com.soma.core.wire.SomaWires;

	import flash.display.Stage;
	import flash.events.Event;
	import flash.utils.Dictionary;

	/**
	 * <p><b>Author:</b> Romuald Quantin - <a href="http://www.soundstep.com/" target="_blank">www.soundstep.com</a></p>
	 * <p><b>Resources:</b> <a href="http://www.soundstep.com/downloads/somacore" target="_blank">http://www.soundstep.com/downloads/somacore</a></p>
	 * <p><b>Class version:</b> v2.0.0</p>
	 * <p><b>Actionscript version:</b> 3.0</p>
	 * <p><b>Copyright:</b>
	 * Mozilla Public License 1.1 (MPL 1.1)<br /> 
	 * <a href="http://www.opensource.org/licenses/mozilla1.1.php" target="_blank">http://www.opensource.org/licenses/mozilla1.1.php</a></p>
	 * Interface used by the class that will extend the Soma class.
	 * @see com.soma.core.Soma
	 */
	
	public interface ISoma {
		
		/**
		 * Registers an event listener object with an EventDispatcher object so that the listener receives notification of an event.
		 * @param type The type of event.
		 * @param listener The listener function that processes the event.
		 * @param useCapture Determines whether the listener works in the capture phase or the target and bubbling phases.
		 * @param priority The priority level of the event listener.
		 * @param useWeakReference Determines whether the reference to the listener is strong or weak.
		 */
		function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void;
		/**
		 * Dispatches an event into the event flow. The event target is the EventDispatcher object upon which dispatchEvent() is called.
		 * @param event The event object dispatched into the event flow.
		 * @return A value of true unless preventDefault() is called on the event, in which case it returns false.
		 */
		function dispatchEvent(event:Event):Boolean;
		/**
		 * Checks whether the EventDispatcher object has any listeners registered for a specific type of event.
		 * @param type The type of event.
		 * @return A value of true if a listener of the specified type is registered; false otherwise.
		 */
		function hasEventListener(type:String):Boolean;
		/**
		 * Removes a listener from the EventDispatcher object. If there is no matching listener registered with the EventDispatcher object, a call to this method has no effect.
		 * @param type The type of event. 
		 * @param listener The listener object to remove. 
		 * @param useCapture Specifies whether the listener was registered for the capture phase or the target and bubbling phases.
		 */
		function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void;
		/**
		 * Checks whether an event listener is registered with this EventDispatcher object or any of its ancestors for the specified event type.
		 * @param type The type of event. 
		 * @return A value of true if a listener of the specified type will be triggered; false otherwise. 
		 */
		function willTrigger(type:String):Boolean;
		
		/**
		 * Register elements that the frameworks needs to be ready, such as the stage and the optional injector class (default is SomaInjector).
		 * @param stage The stage is used as a global EventDispatcher (as well as the Soma class), and is required to instantiate the framework.
		 * @param injectorClass Class that must extend ISomaInjector.
		 */
		function setup(stage:Stage = null, injectorClass:Class = null):void;
		
		/**
		 * Get the stage that has been registered to the framework.
		 * @return The stage instance.
		 */
		function get stage():Stage;
		
		/**
		 * Retrieves the injector Class registered to the framework.
		 * @return A Class.
		 */
		function get injectorClass():Class;
		/**
		 * Retrieves the injector instance that has been created by the framework from the injector Class registered.
		 * @return a ISomaInjector instance (default is SomaInjector).
		 */
		function get injector():ISomaInjector;
		/**
		 * Retrieves the refletor instance.
		 * @return a ISomaReflector instance (default is SomaReflector).
		 */
		function get reflector():ISomaReflector;
		
		
		/**
		 * Gets the model manager instance.
		 */
		function get models():SomaModels;
		/**
		 * Gets the view manager class.
		 */
		function get views():SomaViews;
		/**
		 * Gets the commands manager instance.
		 */
		function get controller():SomaController;
		/**
		 * Gets the wires manager instance.
		 */
		function get wires():SomaWires;
		/**
		 * Gets the mediator manager instance that has been created by the framework from the injector Class registered.
		 */
		function get mediators():SomaMediators;
		
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
		function createPlugin(plugin:Class, pluginVO:ISomaPluginVO):ISomaPlugin;
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
		function createPluginFromClassName(pluginClassName:String, pluginVO:ISomaPluginVO):ISomaPlugin;
		
		/**
		 * Destroys the SomaCore core classes and elements registered to the framework.
		 */
		function dispose():void;
		
		/**
		 * Indicates wether a command has been registered to the framework.
		 * @param commandName Event type that is used as a command name.
		 * @return A Boolean.
		 * @see com.soma.core.controller.SomaController
		 * @example
		 * <listing version="3.0">hasCommand(MyEvent.DOSOMETHING);</listing>
		 */
		function hasCommand(commandName:String):Boolean;
		/**
		 * Registers a command to the framework.
		 * @param commandName Event type that is used as a command name.
		 * @param command Class that will be executed when a command has been dispatched.
		 * @see com.soma.core.controller.SomaController
		 * @example
		 * <listing version="3.0">addCommand(MyEvent.DOSOMETHING, MyCommand);</listing>
		 */
		function addCommand(commandName:String, command:Class):void;
		/**
		 * Removes a command from the framework.
		 * @param commandName Event type that is used as a command name.
		 * @see com.soma.core.controller.SomaController
		 * @example
		 * <listing version="3.0">removeCommand(MyEvent.DOSOMETHING);</listing>
		 */
		function removeCommand(commandName:String):void;
		/**
		 * Retrieves the command class that has been registered with a command name.
		 * @param commandName Event type that is used as a command name.
		 * @return A class.
		 * @see com.soma.core.controller.SomaController
		 * @example
		 * <listing version="3.0">var commandClass:ICommand = getCommand(MyEvent.DOSOMETHING) as ICommand;</listing>
		 */
		function getCommand(commandName:String):Class;
		/**
		 * Retrieves all the command names (event type) that have been registered to the framework.
		 * @return An Array of String (command name).
		 * @see com.soma.core.controller.SomaController
		 * @example
		 * <listing version="3.0">var commands:Array = getCommands();</listing>
		 */
		function getCommands():Array;
		
		/**
		 * Retrieves the sequence command instance using an event instance that has been created from this sequence command.
		 * @param event Event instance.
		 * @return A sequencer (ISequenceCommand).
		 * @see com.soma.core.controller.SomaController
		 * @example
		 * <listing version="3.0">var sequencer:ISequenceCommand = getSequencer(myEvent);</listing>
		 */
		function getSequencer(event:Event):ISequenceCommand;
		/**
		 * Stops a sequence command using an event instance that has been created from this sequence command.
		 * @param event Event instance.
		 * @return A Boolean (true if a sequence command has been stopped).
		 * @see com.soma.core.controller.SomaController
		 * @example
		 * <listing version="3.0">var success:Boolean = stopSequencerWithEvent(myEvent);</listing>
		 */
		function stopSequencerWithEvent(event:Event):Boolean;
		/**
		 * Stops a sequence command using the sequence command instance itself.
		 * @param sequencer The sequence command instance.
		 * @return A Boolean (true if the sequence command has been stopped).
		 * @see com.soma.core.controller.SomaController
		 * @example
		 * <listing version="3.0">var success:Boolean = stopSequencer(mySequenceCommand);</listing>
		 */
		function stopSequencer(sequencer:ISequenceCommand):Boolean;
		/**
		 * Retrieves all the sequence command instances that are running.
		 * @return An Array of ISequenceCommand instances.
		 * @see com.soma.core.controller.SomaController
		 * @example
		 * <listing version="3.0">var sequencers:Array = getRunningSequencers();</listing>
		 */
		function getRunningSequencers():Array;
		/**
		 * Stops all the sequence command instances that are running.
		 * @see com.soma.core.controller.SomaController
		 * @example
		 * <listing version="3.0">stopAllSequencers();</listing>
		 */
		function stopAllSequencers():void;
		/**
		 * Indicates wether an event has been instantiated from a ISequenceCommand class.
		 * @return A Boolean.
		 * @see com.soma.core.controller.SomaController
		 * @example
		 * <listing version="3.0">var inSequence:Boolean = isPartOfASequence(myEvent);</listing>
		 */
		function isPartOfASequence(event:Event):Boolean;
		/**
		 * Retrieves the last sequence command that has been instantiated in the framework.
		 * @return An ISequenceCommand instance.
		 * @see com.soma.core.controller.SomaController
		 * @example
		 * <listing version="3.0">var lastSequencer:ISequenceCommand = getLastSequencer();</listing>
		 */
		function getLastSequencer():ISequenceCommand;
		
		/**
		 * Indicates wether a model has been registered to the framework.
		 * @param modelName Name of the model.
		 * @return A Boolean.
		 * @see com.soma.core.model.SomaModels
		 * @example
		 * <listing version="3.0">hasModel(MyModel.NAME);</listing>
		 */
		function hasModel(modelName:String):Boolean;
		/**
		 * Registers a model to the framework.
		 * @param modelName Name of the model.
		 * @param model Instance of the model.
		 * @return The model instance.
		 * @see com.soma.core.model.SomaModels
		 * @example
		 * <listing version="3.0">addModel(MyModel.NAME, new MyModel());</listing>
		 */
		function addModel(modelName:String, model:IModel):IModel;
		/**
		 * Removes a model from the framework and call the dispose method of this model.
		 * @param modelName Name of the model.
		 * @see com.soma.core.model.SomaModels
		 * @example
		 * <listing version="3.0">removeModel(MyModel.NAME);</listing>
		 */
		function removeModel(modelName:String):void;
		/**
		 * Retrieves the model instance that has been registered using its name.
		 * @param modelName Name of the model.
		 * @return A IModel instance.
		 * @see com.soma.core.model.SomaModels
		 * @example
		 * <listing version="3.0">var myModel:MyModel = getModel(MyModel.NAME) as MyModel;</listing>
		 */
		function getModel(modelName:String):IModel;
		/**
		 * Retrieves all the model instances that have been registered to the framework.
		 * @return A Dictionary (the key of the Dictionary is the name used for the registration).
		 * @see com.soma.core.model.SomaModels
		 * @example
		 * <listing version="3.0">var models:Dictionary = getModels();</listing>
		 */
		function getModels():Dictionary;
		
		/**
		 * Indicates wether a view has been registered to the framework.
		 * @param viewName Name of the view.
		 * @return A Boolean.
		 * @see com.soma.core.view.SomaViews
		 * @example
		 * <listing version="3.0">hasView(MySprite.NAME);</listing>
		 */
		function hasView(viewName:String):Boolean;
		/**
		 * Registers a view to the framework.
		 * @param viewName Name of the view.
		 * @param view Instance of the view.
		 * @return The view instance.
		 * @see  com.soma.core.view.SomaViews
		 * @example
		 * <listing version="3.0">addView(MySprite.NAME, new MySprite());</listing>
		 */
		function addView(viewName:String, view:Object):Object;
		/**
		 * Removes a view from the framework and call the (optional) dispose method of this view.
		 * @param viewName Name of the view.
		 * @see com.soma.core.view.SomaViews
		 * @example
		 * <listing version="3.0">removeView(MySprite.NAME);</listing>
		 */
		function removeView(viewName:String):void;
		/**
		 * Retrieves the view instance that has been registered using its name.
		 * @param viewName Name of the view.
		 * @return An Object instance.
		 * @see com.soma.core.view.SomaViews
		 * @example
		 * <listing version="3.0">var mySprite:MySprite = getView(MySprite.NAME) as MySprite;</listing>
		 */
		function getView(viewName:String):Object;
		/**
		 * Retrieves all the view instances that have been registered to the framework.
		 * @return A Dictionary (the key of the Dictionary is the name used for the registration).
		 * @see com.soma.core.view.SomaViews
		 * @example
		 * <listing version="3.0">var sprites:Dictionary = getViews();</listing>
		 */
		function getViews():Dictionary;
		
		/**
		 * Indicates wether a wire has been registered to the framework.
		 * @param wireName Name of the wire.
		 * @return A Boolean.
		 * @see com.soma.core.wire.SomaWires
		 * @example
		 * <listing version="3.0">hasWire(MyWire.NAME);</listing>
		 */
		function hasWire(wireName:String):Boolean;
		/**
		 * Registers a wire to the framework.
		 * @param wireName Name of the wire.
		 * @param view Instance of the wire.
		 * @return The wire instance.
		 * @see com.soma.core.wire.SomaWires
		 * @example
		 * <listing version="3.0">addWire(MyWire.NAME, new MyWire());</listing>
		 */
		function addWire(wireName:String, wire:IWire):IWire;
		/**
		 * Removes a wire from the framework and call the dispose method of this wire.
		 * @param wireName Name of the wire.
		 * @see com.soma.core.wire.SomaWires
		 * @example
		 * <listing version="3.0">removeWire(MyWire.NAME);</listing>
		 */
		function removeWire(wireName:String):void;
		/**
		 * Retrieves the wire instance that has been registered using its name.
		 * @param wireName Name of the wire.
		 * @return A wire instance.
		 * @see com.soma.core.wire.SomaWires
		 * @example
		 * <listing version="3.0">var myWire:MyWire = getWire(MyWire.NAME) as MyWire;</listing>
		 */
		function getWire(wireName:String):IWire;
		/**
		 * Retrieves all the wire instances that have been registered to the framework.
		 * @return A Dictionary (the key of the Dictionary is the name used for the registration).
		 * @see com.soma.core.wire.SomaWires
		 * @example
		 * <listing version="3.0">var wires:Dictionary = getWires();</listing>
		 */
		function getWires():Dictionary;
		
	}
}