package com.soma.core.model {
	import com.soma.core.interfaces.IModel;
	import com.soma.core.interfaces.ISoma;

	import flash.events.IEventDispatcher;
	import flash.utils.Dictionary;

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
	
	public class SomaModels {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		namespace somans = "http://www.soundstep.com/soma";
		
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