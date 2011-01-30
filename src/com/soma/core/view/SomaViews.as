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

package com.soma.core.view {
	import flash.utils.Dictionary;

	/**
	 * <p><b>Author:</b> Romuald Quantin - <a href="http://www.soundstep.com/" target="_blank">www.soundstep.com</a></p>
	 * <p><b>Resources:</b> <a href="http://www.soundstep.com/downloads/somacore" target="_blank">http://www.soundstep.com/downloads/somacore</a></p>
	 * <p><b>Class version:</b> v2.0.0</p>
	 * <p><b>Actionscript version:</b> 3.0</p>
	 * <p><b>Copyright:</b>
	 * Mozilla Public License 1.1 (MPL 1.1)<br /> 
	 * <a href="http://www.opensource.org/licenses/mozilla1.1.php" target="_blank">http://www.opensource.org/licenses/mozilla1.1.php</a></p>
	 * The SomaViews class handles the views of the application (DisplayObject).
	 * @example
	 * Add a view.
	 * <listing version="3.0">
addView(MySprite.NAME, new MySprite());
	 * </listing>
	 * Remove a view.
	 * <listing version="3.0">
removeView(MySprite.NAME);
	 * </listing>
	 * Retrieve a view.
	 * <listing version="3.0">
var sprite:MySprite = getView(MySprite.NAME) as MySprite;
	 * </listing>
	 * Create a shortcut to retrieve a view is a good practice.
	 * <listing version="3.0">
private function get mySprite():MySprite {
	return getView(MySprite.NAME) as MySprite;
}
private function doSomething():void {
	trace(mySprite);
}
	 * </listing>
	 */
	
	public class SomaViews {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		/** @private */
		protected var views:Dictionary;

		//------------------------------------
		// public properties
		//------------------------------------
		
		
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		/**
		 * Create an instance of the SomaViews class. Should not be directly instantiated, the framework will instantiate the class.
		 */
		public function SomaViews() {
			initialize();
		}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		/** @private */
		private function initialize():void {
			views = new Dictionary();
		}
		
		//
		// PUBLIC
		//________________________________________________________________________________________________
		
		/**
		 * Destroys all the views and properties. The class will call the dispose method of each view instance.
		 */
		public function dispose():void {
			// dispose objects, graphics and events listeners
			for (var name:String in views) {
				removeView(name);
			}
			views = null;
		}
		
		/**
		 * Indicates wether a view has been registered to the framework.
		 * @param viewName Name of the view.
		 * @return A Boolean.
		 * @example
		 * <listing version="3.0">hasView(MySprite.NAME);</listing>
		 */
		public function hasView(viewName:String):Boolean {
			if (!views) return false;
			return (views[viewName] != null || views[viewName] != undefined);
		}
		
		/**
		 * Registers a view to the framework.
		 * @param viewName Name of the view.
		 * @param view Instance of the view.
		 * @return The view instance.
		 * @example
		 * <listing version="3.0">addView(MySprite.NAME, new MySprite());</listing>
		 */
		public function addView(viewName:String, view:Object):Object {
			if (!views) return null;
			if (hasView(viewName)) {
				throw new Error("Error in " + this + " View \"" + viewName + "\" already registered.");
			}
			views[viewName] = view;
			if (Object(views[viewName]).hasOwnProperty("initializeView")) Object(views[viewName]).initializeView();
			return view;
		}
		
		/**
		 * Removes a view from the framework and call the (optional) dispose method of this view.
		 * @param viewName Name of the view.
		 * @example
		 * <listing version="3.0">removeView(MySprite.NAME);</listing>
		 */
		public function removeView(viewName:String):void {
			if (!views) return;
			if (!hasView(viewName)) {
				throw new Error("Error in " + this + " View \"" + viewName + "\" not registered.");
			}
			if (Object(views[viewName]).hasOwnProperty("dispose")) Object(views[viewName]).dispose();
			views[viewName] = null;
			delete views[viewName];
		}
		
		/**
		 * Retrieves the view instance that has been registered using its name.
		 * @param viewName Name of the view.
		 * @return An Object instance.
		 * @example
		 * <listing version="3.0">var mySprite:MySprite = getView(MySprite.NAME) as MySprite;</listing>
		 */
		public function getView(viewName:String):Object {
			if (!views) return null;
			if (!hasView(viewName)) return null;
			return views[viewName];
		}
		
		/**
		 * Retrieves all the view instances that have been registered to the framework.
		 * @return A Dictionary (the key of the Dictionary is the name used for the registration).
		 * @example
		 * <listing version="3.0">var sprites:Dictionary = getViews();</listing>
		 */
		public function getViews():Dictionary {
			if (!views) return null;
			var clone:Dictionary = new Dictionary();
			for (var name:String in views) clone[name] = views[name];
			return clone;
		}
		
	}
}