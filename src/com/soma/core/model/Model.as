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
	 * 
	 * @example
	 * <listing version="3.0">
	 * </listing>
	 */
	
	public class Model implements IModel {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		protected var _dispatcher:IEventDispatcher;
		protected var _data:Object;
		protected var _name:String;

		//------------------------------------
		// public properties
		//------------------------------------
		
		public static var NAME:String = "Soma::Model";
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		public function Model(name:String = null, data:Object = null, dispatcher:IEventDispatcher = null) {
			if (name != "" && name != null) _name = name;
			_data = data;
			_dispatcher = dispatcher;
		}

		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		protected function initialize():void {
			
		}
		
		protected function dispose():void {
			
		}
		
		//
		// PUBLIC
		//________________________________________________________________________________________________
		
		somans function registerDispatcher(dispatcher:IEventDispatcher):void {
			if (!_dispatcher) _dispatcher = dispatcher;
			initialize();
		}
		
		somans function dispose():void {
			dispose();
		}
		
		public final function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void {
			_dispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}

		public final function dispatchEvent(event:Event):Boolean {
			return _dispatcher.dispatchEvent(event);
		}
		
		public final function hasEventListener(type:String):Boolean {
			return _dispatcher.hasEventListener(type);
		}
		
		public final function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void {
			_dispatcher.removeEventListener(type, listener, useCapture);
		}

		public final function willTrigger(type:String):Boolean {
			return _dispatcher.willTrigger(type);
		}
		
		public final function getName():String {
			return _name;
		}
		
		public final function setName(value:String):void {
			_name = value;
		}
		
		public final function get data():Object {
			return _data;
		}
		
		public final function set data(value:Object):void {
			_data = value;
		}
		
		public final function get dispatcher():IEventDispatcher {
			return _dispatcher;
		}
		
		public final function set dispatcher(value:IEventDispatcher):void {
			_dispatcher = value;
		}
		
	}
}