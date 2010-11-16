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
 * The Original Code is SomaDebugger.
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
 
 package com.soma.debugger.views {
	import com.soma.debugger.SomaDebugger;
	import com.soma.debugger.events.SomaDebuggerEvent;
	import com.soma.debugger.views.SomaDebuggerMainWindow;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TextEvent;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import flash.utils.describeType;
	import flash.utils.getQualifiedClassName;

	/**
	 * <b>Author:</b> Romuald Quantin - <a href="http://www.soundstep.com/" target="_blank">www.soundstep.com</a><br />
	 * <b>Class version:</b> v1.0.1<br />
	 * <b>Actionscript version:</b> 3.0<br />
	 * <b>Copyright:</b>
	 * Mozilla Public License 1.1 (MPL 1.1)<br /> 
	 * <a href="http://www.opensource.org/licenses/mozilla1.1.php" target="_blank">http://www.opensource.org/licenses/mozilla1.1.php</a><br />
	 * <br />
	 * <b>Usage:</b><br />
	 * @example
	 * <listing version="3.0">
	 * </listing>
	 */
	
	public class SomaDebuggerView extends Sprite {
		
		namespace somans = "http://www.soundstep.com/soma";

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		private var _debuggerName:String;
		private var _mainWindow:SomaDebuggerMainWindow;
		private var _gcDetails:SomaDebuggerWindow;
		private var _subWindowContainer:Sprite;
		
		private var _count:int;
		
		private var _widthWindow:Number;
		private var _heightWindow:Number;
		
		private var _objects:Dictionary;
		private var _countObjects:int;
		
		//------------------------------------
		// public properties
		//------------------------------------
		
		public var enableLog:Boolean = true;
		public var enableTrace:Boolean = false;
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		public function SomaDebuggerView(debuggerName:String) {
			_debuggerName = debuggerName;
			addEventListener(Event.ADDED_TO_STAGE, added, false, 0, true);
		}

		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		private function added(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, added, false);
			initialize();
		}
		
		private function initialize():void {
			createObjectsReference();
			_widthWindow = SomaDebugger.DEFAULT_WINDOW_WIDTH;
			_heightWindow = SomaDebugger.DEFAULT_WINDOW_HEIGHT;
			createMainWindow();
			createSubWindowContainer();
			createGCDetails();
		}
		
		private function createObjectsReference():void {
			_objects = new Dictionary(SomaDebugger.WEAK_REFERENCE);
			_countObjects = 0;
			_count = 1;
		}
		
		private function registerObject(obj:Object):int {
			if (_objects[obj] == undefined) {
				_objects[obj] = _countObjects++;
				return _countObjects-1;
			}
			else return _objects[obj];
		}

		private function createMainWindow():void {
			_mainWindow = addChild(new SomaDebuggerMainWindow(_debuggerName, _widthWindow, _heightWindow)) as SomaDebuggerMainWindow;
			_mainWindow.addEventListener(Event.CLOSE, closeHandler);
			_mainWindow.addEventListener(SomaDebuggerMainWindow.SELECT_GC_DETAILS, somans::showHideGCDetails);
			_mainWindow.textfield.addEventListener(TextEvent.LINK, openObject);
		}
		
		private function createSubWindowContainer():void {
			_subWindowContainer = addChild(new Sprite) as Sprite;
		}
		
		private function createGCDetails():void {
			_gcDetails = new SomaDebuggerWindow("Garbage Collection", SomaDebugger.DEFAULT_WINDOW_GC_REPORT_WIDTH, SomaDebugger.DEFAULT_WINDOW_GC_REPORT_HEIGHT);
			_gcDetails.addEventListener(Event.ENTER_FRAME, centerGCDetails);
			_gcDetails.addEventListener(Event.CLOSE, somans::showHideGCDetails);
			_gcDetails.textfield.addEventListener(TextEvent.LINK, openObject);
			_subWindowContainer.addChild(_gcDetails);
			somans::showHideGCDetails();
		}
		
		private function centerGCDetails(e:Event):void {
			if (stage.stageWidth > 0) {
				_gcDetails.removeEventListener(Event.ENTER_FRAME, centerGCDetails);
				_gcDetails.x = stage.stageWidth * .5 - _gcDetails.width * .5;
				_gcDetails.y = stage.stageHeight * .5 - _gcDetails.height * .5;
			}
		}
		
		private function closeHandler(event:Event):void {
			dispatchEvent(new SomaDebuggerEvent(SomaDebuggerEvent.HIDE_DEBUGGER, null, _debuggerName));
		}

		private function formatTrace(value:String):String {
			var str:String = value;
			str = str.replace(new RegExp("<br/>", "g"), "\n");
			str = str.replace(new RegExp("<([^>\\s]+)(\\s[^>]+)*>", "g"), "");
			return str;
		}
		
		private function openObject(e:TextEvent):void {
			for (var o:Object in _objects) {
				if (_objects[o] == int(e.text)) {
					createInspectWindow(o);
					return;
				}
			}
			var msg:String = "Unfortunately, it is impossible to inspect this object!<br/><br/>";
			msg += "The reasons might be that this object has been destroyed, garbage collected or is null.<br/><br/>";			msg += "To force the inspection of that object, you can either hold this object in a private variable or set the static variable SomaDebugger.WEAK_REFERENCE to false (default is true).<br/><br/>Preferably you can set this variable before the creation of the debugger. With a property WEAK_REFERENCE set to false, the debugger will hold any inspected object and prevents the garbage collection of this object.";
			createInspectWindow(msg);
		}
		
		private function createInspectWindow(obj:Object):void {
			var window:SomaDebuggerWindow = new SomaDebuggerWindow(getType(getQualifiedClassName(obj)), SomaDebugger.DEFAULT_WINDOW_INSPECTOR_WIDTH, SomaDebugger.DEFAULT_WINDOW_INSPECTOR_HEIGHT);
			var point:Point = new Point(stage.stageWidth * .5 - SomaDebugger.DEFAULT_WINDOW_INSPECTOR_WIDTH * .5, stage.stageHeight * .5 - SomaDebugger.DEFAULT_WINDOW_INSPECTOR_HEIGHT * .5);
			window.x = globalToLocal(point).x;
			window.y = globalToLocal(point).y;
			window.addEventListener(Event.CLOSE, closeWindowHandler);
			window.textfield.addEventListener(TextEvent.LINK, openObject);
			_subWindowContainer.addChild(window);
			setWindowInspectorText(window, obj);
			dispatchEvent(new SomaDebuggerEvent(SomaDebuggerEvent.MOVE_TO_TOP));
		}

		private function closeWindowHandler(e:Event):void {
			var window:SomaDebuggerWindow = e.currentTarget as SomaDebuggerWindow;
			window.removeEventListener(Event.CLOSE, closeWindowHandler);
			window.textfield.removeEventListener(TextEvent.LINK, openObject);
			window.dispose();
			_subWindowContainer.removeChild(window);
			window = null;
		}
		
		private function getInspectorFormattedProperty(key:Object, obj:Object, isMethod:Boolean = false, classTypeDescribed:String = null):String {
			var val:Object = (isMethod) ? obj[key]() : obj[key];
			var type:String = (classTypeDescribed != null) ? getType(classTypeDescribed) : getType(getQualifiedClassName(val));
			var str:String = "";
			var link:int = registerObject(val);
			if (isCustomClass(val)) str += '<br/>      <a href="event:' + link + '"><font color="#00009B">' + key + ":</font> ";
			else str += '<br/>      <a href="event:' + link + '"><font color="#00009B">' + key + ":</font> ";
			str += getValue(val);
			str += ' <font color="#997E17">(' + type + ")</font>";
			str += '</a>';
			return str;
		}
		
		private function setWindowInspectorText(window:SomaDebuggerWindow, obj:Object):void {
			var str:String = '<font color="#881260">TYPE: </font><font color="#997E17">' + getType(getQualifiedClassName(obj)) + '</font>';
			if (getQualifiedClassName(obj) == "Object") {
				// dynamic object
				 for (var s:String in obj) {
				 	str += getInspectorFormattedProperty(s, obj);
				 }
			}
			else if (getQualifiedClassName(obj) == "flash.utils::Dictionary") {
				// dictionary
				 for (var o:Object in obj) {
				 	str += getInspectorFormattedProperty(o, obj);
				 }
			}
			else if (getQualifiedClassName(obj) == "Array") {
				// array
				var j:int = 0;
				var al:int = obj.length;
				for (j=0; j<al; ++j) {
					str += getInspectorFormattedProperty(j, obj);
				}
			}
			else if (getQualifiedClassName(obj).search(new RegExp("(__AS3__.vec::Vector.*?)", "gm")) != -1) {
				// vector
				var vi:int = 0;
				var vil:int = obj.length;
				for (; vi<vil; ++vi) {
					str += getInspectorFormattedProperty(vi, obj);
				}
			}
			else {
				// custom
				try {
					var variables:XMLList = getVariables(obj);
					var i:int = 0;
					var vl:int = variables.length();
					if (vl > 0) str += '<br/><br/><font color="#881260">VARIABLES: </font>';
					var name:String;
					var type:String;
					// variables
					for (i=0; i<vl; ++i) {
						name = variables[i].@name;
						type = variables[i].@type;
						str += getInspectorFormattedProperty(name, obj, false, type);
					}
					if (isCustomClass(obj)) {
						var accessors:XMLList = getAccessors(obj);
						i = 0;
						vl = accessors.length();
						if (vl > 0) str += '<br/><br/><font color="#881260">ACCESSORS: </font>';
						for (i=0; i<vl; ++i) {
							name = accessors[i].@name;
							type = accessors[i].@type;
							if (obj.hasOwnProperty(name) && name != "textSnapshot") {
								str += getInspectorFormattedProperty(name, obj, false, type);
							}
						}
						var methods:XMLList = getMethods(obj);
						i = 0;
						vl = methods.length();
						if (vl > 0) str += '<br/><br/><font color="#881260">METHODS: </font>'; 
						for (i=0; i<vl; ++i) {
							name = methods[i].@name;
							type = methods[i].@type;
							if (obj.hasOwnProperty(name) && !methods[i].hasOwnProperty("parameter")) {
								str += getInspectorFormattedProperty(name, obj, true, type);
							}
						}
					}
					variables = null;
				} catch (err:Error) {trace(err);}
			}
			str += '<br/><br/><font color="#881260">VALUE: </font>';
			if (obj is XML || obj is XMLList) {
				var strXML:String = obj.toXMLString();
				strXML = strXML.replace(new RegExp("(<.*?)", "gm"), "&lt;");
				str += strXML;
			}
			else {
				str += String(obj);
				if (obj is uint) str += " - " + "0x" + int(obj).toString(16).toUpperCase();
			}
			window.textfield.htmlText = str;
		}

		private function getType(className:String):String {
			var str:String;
			if (className.search("::") == -1) str = className;
			else str = className.substr(className.lastIndexOf("::")+ 2);
			str = str.replace(new RegExp("(<.*?)", "gm"), "&lt;");
			str = str.replace(new RegExp("(>.*?)", "gm"), "&gt;");
			return str;
		}
		
		private function isCustomClass(obj:Object):Boolean {
			return !(obj is Number || obj is Boolean || obj is String || obj == null || getQualifiedClassName(obj) == "Object" || getQualifiedClassName(obj) == "Array");
		}
		
		private function getValue(value:Object):String {
			var type:String = getQualifiedClassName(value);
			if (value is Boolean) {
				return Boolean(value).toString();
			}
			else if (value is String) {
				return (String(value).length > SomaDebugger.DEFAULT_LOG_MAX_STRING_LENGTH ? String(value).substr(0, SomaDebugger.DEFAULT_LOG_MAX_STRING_LENGTH)+"..." : String(value));
			}
			else if (getQualifiedClassName(value) == "Object") {
				return "Object";
			}
			else if (getQualifiedClassName(value) == "Array") {
				return "Array (" + value.length + ")";
			}
			else if (getQualifiedClassName(value).search(new RegExp("(__AS3__.vec::Vector.*?)", "gm")) != -1) {
				return "Vector (" + value.length + ")";
			}
			else if (value is uint) {
				return String(value) + " - " + "0x" + int(value).toString(16).toUpperCase();
			}
			else if (isCustomClass(value)) {
				return getType(type);
			}
			return String(value);
		}
		
		private function getPrintString(value:Object, info:String = null):String {
			var link:int = registerObject(value);
			var type:String = getQualifiedClassName(value);
			var str:String = '<a href="event:' + link + '">';
			var infoValue:String = (info) ? info : "PRINT";
			var infoColor:String = (info) ? "6A9100" : "881260";
			str += '<font color="#' + infoColor + '">' + infoValue + ' ></font> ' + getValue(value);
			str += ' <font color="#997E17">(' + getType(type) + ')</font></a>';
			return str;
		}
		
		private function getVariables(obj:Object):XMLList {
			return describeType(obj)..*.(localName() == "variable");
		}

		private function getAccessors(obj:Object):XMLList {
			return describeType(obj)..*.(localName() == "accessor" && String(@access) != "writeonly");
		}

		private function getMethods(obj:Object):XMLList {
			return describeType(obj)..*.(localName() == "method" && String(@returnType) != "void");
		}
		
		// GC WATCHERS
		
		somans function printAddWatcher(name:String, obj:Object):void {
			var link:int = registerObject(obj);
			var type:String = getQualifiedClassName(obj);
			var str:String = '<a href="event:' + link + '">';
			str += '<font color="#650BB6">GC ADD WATCHER > </font>\"' + name + '\"';
			str += ' <font color="#997E17">(' + getType(type) + ')</font></a>';
			if (enableTrace) trace(_count + ". " + formatTrace(str));
			if (enableLog) _mainWindow.textfield.htmlText = _count + ". " + str + "<br/>" + _mainWindow.textfield.htmlText;
			_count++;
		}

		somans function printRemoveWatcher(name:String):void {
			var str:String = '<font color="#650BB6">GC REMOVE WATCHER > </font>\"' + name + '\"';
			if (enableTrace) trace(_count + ". " + formatTrace(str));
			if (enableLog) _mainWindow.textfield.htmlText = _count + ". " + str + "<br/>" + _mainWindow.textfield.htmlText;
			_count++;
		}

		somans function printClearWatcher():void {
			var str:String =  '<font color="#650BB6">GC CLEAR WATCHERS</font>';
			if (enableTrace) trace(_count + ". " + formatTrace(str));
			if (enableLog) _mainWindow.textfield.htmlText = _count + ". " + str + "<br/>" + _mainWindow.textfield.htmlText;
			_count++;
		}
		
		somans function printGCollected(name:String):void {
			var str:String =  '<font color="#650BB6">GC RELEASE > </font>\"' + name + '\"';
			if (enableTrace) trace(_count + ". " + formatTrace(str));
			if (enableLog && _mainWindow != null) _mainWindow.textfield.htmlText = _count + ". " + str + "<br/>" + _mainWindow.textfield.htmlText;
			_count++;
		}
		
		somans function printGCReport(watchers:Dictionary, names:Object, namesCopy:Array, count:Number, retained:Number):void {
			var str:String = '';
			if (!SomaDebugger.WEAK_REFERENCE) {
				str += "You must set the property SomaDebugger.WEAK_REFERENCE to true to be able to watch the garbage collection.";
			}
			else if (count == 0) {
				str += "No objects to watch!";
			}
			else {
				str += '<font color="#650BB6">Objects retained: </font>' + retained + '<br/>';
				str += '<font color="#650BB6">Objects released: </font>' + (count - retained) + '<br/>';
				str += '<br/><font color="#650BB6">List of objects:</font><br/>';
				var list:Dictionary = new Dictionary();
				for (var n:String in names) {
					list[n] = null;
				}
				for (var o:Object in watchers) {
					list[watchers[o]] = o;
				}
				for (var i:int=0; i<namesCopy.length; ++i) {
					var name:String = namesCopy[i];
					var obj:Object = list[name];
					var status:String = (obj == null) ? "released" : "retained";
					var type:String = getQualifiedClassName(obj);
					var link:int = registerObject(obj);
					str += '<br/>    <a href="event:' + link + '">';
					str += name + ' <font color="#997E17">(' + getType(type) + ')</font></a>';
					str += ' - status: <font color="#' + ((status == "released") ? "2BA51C" : "D31A14") + '">' + status + '</font></a>';
				}
				list = null;
			}
			if (_gcDetails != null && _gcDetails.textfield) _gcDetails.textfield.htmlText = str;
		}
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		public function printCommand(type:String, event:Event):void {
			var str:String = "";
			if (event) {
				var link:int = registerObject(event);
				str = '<font color="#4E7B8B">EVENT > <a href="event:' + link + '">' + type + '</a></font>';
				if (SomaDebugger.DEFAULT_DISPLAY_COMMANDS_PROPERTIES) {
					var variables:XMLList = getVariables(event);
					var i:int = 0;
					var vl:int = variables.length();
					for (i=0; i<vl; ++i) {
						var name:String = variables[i].@name;
						type = variables[i].@type;
						if (event[name] != null) {
							var linkVar:int = registerObject(event[name]);
							str += '<br/>      <a href="event:' + linkVar + '"><font color="#00009B">' + name  + ":</font> " + getValue(event[name]) + ' <font color="#997E17">(' + getType(type) + ")</font></a>";
							if (variables[i].@type == "uint") str += " - " + "0x" + int(event[name]).toString(16).toUpperCase();
						}
					}
					variables = null;
					
				}
			}
			if (enableTrace) trace(_count + ". " + formatTrace(str));
			if (enableLog && _mainWindow != null) _mainWindow.textfield.htmlText = _count + ". " + str + "<br/>" + _mainWindow.textfield.htmlText;
			_count++;
		}
		
		public function print(value:Object, info:String = null):void {
			var str:String = getPrintString(value, info);
			if (enableTrace) trace(_count + ". " + formatTrace(str));
			if (enableLog && _mainWindow != null) _mainWindow.textfield.htmlText = _count + ". " + str + "<br/>" + _mainWindow.textfield.htmlText;
			_count++;
		}
		
		public function clear():void {
			_mainWindow.textfield.htmlText = "";
			createObjectsReference();
		}
		
		public function dispose() : void {
			// dispose objects, graphics and events listeners
			try {
				removeEventListener(Event.ADDED_TO_STAGE, added, false);
				_gcDetails.removeEventListener(Event.ENTER_FRAME, centerGCDetails);
				_gcDetails.removeEventListener(Event.CLOSE, somans::showHideGCDetails);
				_mainWindow.removeEventListener(Event.CLOSE, closeHandler);
				_mainWindow.removeEventListener(SomaDebuggerMainWindow.SELECT_GC_DETAILS, somans::showHideGCDetails);
				_mainWindow.dispose();
				while (_subWindowContainer.numChildren > 0) {
					if (_subWindowContainer.getChildAt(0).hasOwnProperty("dispose")) {
						_subWindowContainer.getChildAt(0)["dispose"]();
					}
					_subWindowContainer.removeChildAt(0);
				}
				while (numChildren > 0) removeChildAt(0);
				_gcDetails = null;
				_mainWindow = null;
				_subWindowContainer = null;
				_objects = null;
			} catch(e:Error) {
				trace("Error in", this, "(dispose method):", e.message);
			}
		}
		
		public function get debuggerName():String {
			return _debuggerName;
		}
		
		public function get mainWindow():SomaDebuggerMainWindow {
			return _mainWindow;
		}
		
		public function get stats():SomaDebuggerStats {
			return _mainWindow.stats;
		}
		
		somans function get gc():SomaDebuggerGC {
			if (_mainWindow == null) return null;
			return _mainWindow.gc;
		}
		
		somans function showHideGCDetails(e:Event = null):void {
			_gcDetails.visible = !_gcDetails.visible;
		}
		
	}
}
