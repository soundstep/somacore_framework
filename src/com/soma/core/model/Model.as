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

	import flash.events.Event;
	import flash.events.IEventDispatcher;

	/**
	 * <p><b>Author:</b> Romuald Quantin - <a href="http://www.soundstep.com/" target="_blank">www.soundstep.com</a></p>
	 * <p><b>Resources:</b> <a href="http://www.soundstep.com/downloads/somacore" target="_blank">http://www.soundstep.com/downloads/somacore</a></p>
	 * <p><b>Class version:</b> v1.0.0</p>
	 * <p><b>Actionscript version:</b> 3.0</p>
	 * <p><b>Copyright:</b>
	 * Mozilla Public License 1.1 (MPL 1.1)<br /> 
	 * <a href="http://www.opensource.org/licenses/mozilla1.1.php" target="_blank">http://www.opensource.org/licenses/mozilla1.1.php</a></p>
	 * <p>The model is the class used to manage you application's data model.</p>
	 * <p>The data can be XML, local data, data retrieved from a server or anything. Ideally, the data should be set to the data property of the model instance, but you are free to create specific getters.</p>
	 * @example
	 * Create a model.
	 * <listing version="3.0">
package  {
	import com.soma.core.interfaces.IModel;
	import com.soma.core.model.Model;
	
	public class ModelExample extends Model implements IModel {
		
		public static const NAME:String = "Model example name";
		
		public function ModelExample() {
			super(NAME);
		}
		
		override protected function initialize():void {
			// called when the model has been registered to the framework
			data = new XML('&lt;myXML/&gt;');
			// you can use the model as a dispatcher (default dispatcher is the framework instance) to dispatch commands, example:
			dispatchEvent(new MyEvent(MyEvent.DATA_READY));
		}
		
		override protected function dispose():void {
			// called when the model has been removed from the framework
			data = null;
		}
		
	}
}
	 * </listing>
	 * Add a model.
	 * <listing version="3.0">
addModel(ModelExample.NAME, new ModelExample());
	 * </listing>
	 * Remove a model.
	 * <listing version="3.0">
removeModel(ModelExample.NAME);
	 * </listing>
	 * Retrieve a model.
	 * <listing version="3.0">
var model:ModelExample = getModel(ModelExample.NAME) as ModelExample;
	 * </listing>
	 * Create a shortcut to retrieve a model is a good practice.
	 * <listing version="3.0">
private function get modelExample():ModelExample {
	return getModel(ModelExample.NAME) as ModelExample;
}
private function doSomething():void {
	trace(modelExample.data);
}
	 * </listing>
	 * @see com.soma.core.model.SomaModels
	 */
	
	public class Model implements IModel {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		/**
		 * Instance of a EventDispatcher that can be used to dispatch commands.
		 * @default Framework instance (Soma instance).
		 */
		protected var _dispatcher:IEventDispatcher;
		/**
		 * Variable that can be used to hold you data.
		 * @default null;
		 */
		protected var _data:Object;
		/**
		 * Name of the model.
		 */
		protected var _name:String;
		
		//------------------------------------
		// public properties
		//------------------------------------
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		/**
		 * Create an instance of a Model class. The Model class should be extended.
		 * @param name Name of the model.
		 * @param data Data of the model.
		 * @param dispatcher EventDispatcher instance that can be used to dispatch commands.
		 */
		public function Model(name:String = null, data:Object = null, dispatcher:IEventDispatcher = null) {
			if (name != "" && name != null) _name = name;
			_data = data;
			_dispatcher = dispatcher;
		}

		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		//
		// PUBLIC
		//________________________________________________________________________________________________
		
		/**
		 * Method that can you can override, called when the model has been registered to the framework.
		 */
		public function initialize():void {
			
		}
		
		/**
		 * Method that can you can override, called when the model has been removed from the framework.
		 */
		public function dispose():void {
			
		}
		
		/**
		 * Registers an event listener object with an EventDispatcher object so that the listener receives notification of an event.
		 * @param type The type of event.
		 * @param listener The listener function that processes the event.
		 * @param useCapture Determines whether the listener works in the capture phase or the target and bubbling phases.
		 * @param priority The priority level of the event listener.
		 * @param useWeakReference Determines whether the reference to the listener is strong or weak.
		 */
		public final function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void {
			_dispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		/**
		 * Dispatches an event into the event flow. The event target is the EventDispatcher object upon which dispatchEvent() is called.
		 * @param event The event object dispatched into the event flow.
		 * @return A value of true unless preventDefault() is called on the event, in which case it returns false.
		 */
		public final function dispatchEvent(event:Event):Boolean {
			return _dispatcher.dispatchEvent(event);
		}
		
		/**
		 * Checks whether the EventDispatcher object has any listeners registered for a specific type of event.
		 * @param type The type of event.
		 * @return A value of true if a listener of the specified type is registered; false otherwise.
		 */
		public final function hasEventListener(type:String):Boolean {
			return _dispatcher.hasEventListener(type);
		}
		
		/**
		 * Removes a listener from the EventDispatcher object. If there is no matching listener registered with the EventDispatcher object, a call to this method has no effect.
		 * @param type The type of event. 
		 * @param listener The listener object to remove. 
		 * @param useCapture Specifies whether the listener was registered for the capture phase or the target and bubbling phases.
		 */
		public final function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void {
			_dispatcher.removeEventListener(type, listener, useCapture);
		}
		
		/**
		 * Checks whether an event listener is registered with this EventDispatcher object or any of its ancestors for the specified event type.
		 * @param type The type of event. 
		 * @return A value of true if a listener of the specified type will be triggered; false otherwise. 
		 */
		public final function willTrigger(type:String):Boolean {
			return _dispatcher.willTrigger(type);
		}
		
		/**
		 * Retrieves the name of the model.
		 * @return A String.
		 */
		public final function getName():String {
			return _name;
		}
		
		/**
		 * Sets the name of the model.
		 * @param value A String.
		 */
		public final function setName(value:String):void {
			_name = value;
		}
		
		/**
		 * Data of the model.
		 */
		public final function get data():Object {
			return _data;
		}
		
		public final function set data(value:Object):void {
			_data = value;
		}
		
		/**
		 * EventDispatcher instance of the model.
		 * @default The framework instance.
		 */
		public final function get dispatcher():IEventDispatcher {
			return _dispatcher;
		}
		
		[Inject]
		[Named(index=1, name="somaDispatcher")]
		public final function set dispatcher(value:IEventDispatcher):void {
			_dispatcher = value;
		}
		
	}
}