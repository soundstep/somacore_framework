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

package com.soma.core.model {
	import com.soma.core.ns.somans;
	import com.soma.core.interfaces.IModel;
	import com.soma.core.interfaces.ISoma;

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
	
	public class SomaModels {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		private var _instance:ISoma;
			
		protected var models:Dictionary;

		//------------------------------------
		// public properties
		//------------------------------------
		
		
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		public function SomaModels(instance:ISoma) {
			_instance = instance;
			initialize();
		}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		private function initialize():void {
			models = new Dictionary();
		}
		
		//
		// PUBLIC
		//________________________________________________________________________________________________
		
		public function dispose() : void {
			for (var name:String in models) {
				removeModel(name);
			}
			_instance = null;
			models = null;
		}
		
		public function hasModel(modelName:String):Boolean {
			if (!models) return false;
			return (models[modelName] != null || models[modelName] != undefined);
		}
		
		public function addModel(modelName:String, model:IModel):IModel {
			if (!models) return null;
			if (hasModel(modelName)) {
				throw new Error("Error in " + this + " Model \"" + modelName + "\" already registered.");
			}
			models[modelName] = model;
			Model(model).somans::registerDispatcher(_instance as IEventDispatcher);
			return model;
		}
		
		public function removeModel(modelName:String):void {
			if (!models) return;
			if (!hasModel(modelName)) {
				throw new Error("Error in " + this + " Model \"" + modelName + "\" not registered.");
			}
			Model(models[modelName]).somans::dispose();
			models[modelName] = null;
			delete models[modelName];
		}
		
		public function getModel(modelName:String):IModel {
			if (!models) return null;
			if (!hasModel(modelName)) return null;
			return models[modelName];
		}
		
		public function getModels():Dictionary {
			if (!models) return null;
			var clone:Dictionary = new Dictionary();
			for (var name:String in models) clone[name] = models[name];
			return clone;
		}
		
	}
}