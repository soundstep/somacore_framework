package com.soma.core.view {
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
	
	public class SomaViews {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		protected var views:Dictionary;

		//------------------------------------
		// public properties
		//------------------------------------
		
		
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		public function SomaViews() {
			initialize();
		}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		private function initialize():void {
			views = new Dictionary();
		}
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		public function dispose() : void {
			// dispose objects, graphics and events listeners
			for (var name:String in views) {
				removeView(name);
			}
			views = null;
		}
		
		public function hasView(viewName:String):Boolean {
			if (!views) return false;
			return (views[viewName] != null || views[viewName] != undefined);
		}
		
		public function addView(viewName:String, view:Object):Object {
			if (!views) return null;
			if (hasView(viewName)) {
				throw new Error("Error in " + this + " View \"" + viewName + "\" already registered.");
			}
			views[viewName] = view;
			if (Object(views[viewName]).hasOwnProperty("initializeView")) Object(views[viewName]).initializeView();
			return view;
		}
		
		public function removeView(viewName:String):void {
			if (!views) return;
			if (!hasView(viewName)) {
				throw new Error("Error in " + this + " View \"" + viewName + "\" not registered.");
			}
			if (Object(views[viewName]).hasOwnProperty("dispose")) Object(views[viewName]).dispose();
			views[viewName] = null;
			delete views[viewName];
		}
		
		public function getView(viewName:String):Object {
			if (!views) return null;
			if (!hasView(viewName)) return null;
			return views[viewName];
		}
		
		public function getViews():Dictionary {
			if (!views) return null;
			var clone:Dictionary = new Dictionary();
			for (var name:String in views) clone[name] = views[name];
			return clone;
		}
		
	}
}