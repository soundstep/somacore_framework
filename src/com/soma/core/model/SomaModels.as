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
	import com.soma.core.interfaces.IModel;
	import com.soma.core.interfaces.ISoma;

	import flash.events.IEventDispatcher;
	import flash.utils.Dictionary;

	/**
	 * <p><b>Author:</b> Romuald Quantin - <a href="http://www.soundstep.com/" target="_blank">www.soundstep.com</a></p>
	 * <p><b>Resources:</b> <a href="http://www.soundstep.com/downloads/somacore" target="_blank">http://www.soundstep.com/downloads/somacore</a></p>
	 * <p><b>Actionscript version:</b> 3.0</p>
	 * <p><b>Copyright:</b>
	 * Mozilla Public License 1.1 (MPL 1.1)<br /> 
	 * <a href="http://www.opensource.org/licenses/mozilla1.1.php" target="_blank">http://www.opensource.org/licenses/mozilla1.1.php</a></p>
	 * The SomaModels class handles the models of the application. See the Model class documentation for implementation.
	 * @see com.soma.core.model.Model
	 */
	
	public class SomaModels {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		/** @private */
		private var _instance:ISoma;
		/**
		 * List of the models registered to the framework.
		 */
		protected var models:Dictionary;

		//------------------------------------
		// public properties
		//------------------------------------
		
		
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		/**
		 * Create an instance of the SomaModels class. Should not be directly instantiated, the framework will instantiate the class.
		 * @param instance Framework instance.
		 */
		public function SomaModels(instance:ISoma) {
			_instance = instance;
			initialize();
		}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		/** @private */
		private function initialize():void {
			models = new Dictionary();
		}
		
		//
		// PUBLIC
		//________________________________________________________________________________________________
		
		/**
		 * Destroys all the models and properties. The class will call the dispose method of each model instance.
		 */
		public function dispose():void {
			for (var name:String in models) {
				removeModel(name);
			}
			_instance = null;
			models = null;
		}
		
		/**
		 * Indicates whether a model has been registered to the framework.
		 * @param modelName Name of the model.
		 * @return A Boolean.
		 * @example
		 * <listing version="3.0">hasModel(MyModel.NAME);</listing>
		 */
		public function hasModel(modelName:String):Boolean {
			if (!models) return false;
			return (models[modelName] != null || models[modelName] != undefined);
		}
		
		/**
		 * Registers a model to the framework.
		 * @param modelName Name of the model.
		 * @param model Instance of the model.
		 * @return The model instance.
		 * @example
		 * <listing version="3.0">addModel(MyModel.NAME, new MyModel());</listing>
		 */
		public function addModel(modelName:String, model:IModel):IModel {
			if (!models) return null;
			if (hasModel(modelName)) {
				throw new Error("Error in " + this + " Model \"" + modelName + "\" already registered.");
			}
			models[modelName] = model;
			if (!model.dispatcher) model.dispatcher = _instance as IEventDispatcher;
			model.initialize();
			return model;
		}
		
		/**
		 * Removes a model from the framework and call the dispose method of this model.
		 * @param modelName Name of the model.
		 * @example
		 * <listing version="3.0">removeModel(MyModel.NAME);</listing>
		 */
		public function removeModel(modelName:String):void {
			if (!models) return;
			if (!hasModel(modelName)) {
				throw new Error("Error in " + this + " Model \"" + modelName + "\" not registered.");
			}
			Model(models[modelName]).dispose();
			models[modelName] = null;
			delete models[modelName];
		}
		
		/**
		 * Retrieves the model instance that has been registered using its name.
		 * @param modelName Name of the model.
		 * @return A IModel instance.
		 * @example
		 * <listing version="3.0">var myModel:MyModel = getModel(MyModel.NAME) as MyModel;</listing>
		 */
		public function getModel(modelName:String):IModel {
			if (!models) return null;
			if (!hasModel(modelName)) return null;
			return models[modelName];
		}
		
		/**
		 * Retrieves all the model instances that have been registered to the framework.
		 * @return A Dictionary (the key of the Dictionary is the name used for the registration).
		 * @example
		 * <listing version="3.0">var models:Dictionary = getModels();</listing>
		 */
		public function getModels():Dictionary {
			if (!models) return null;
			var clone:Dictionary = new Dictionary();
			for (var name:String in models) clone[name] = models[name];
			return clone;
		}
		
	}
}