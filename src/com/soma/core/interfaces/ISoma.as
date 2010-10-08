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
	import com.soma.core.model.SomaModels;
	import com.soma.core.view.SomaViews;
	import com.soma.core.wire.SomaWires;

	import flash.display.Stage;
	import flash.events.Event;
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
		function createPluginFromClassName(pluginClassName:String, pluginVO:ISomaPluginVO):ISomaPlugin;
		
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