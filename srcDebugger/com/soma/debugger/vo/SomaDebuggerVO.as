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
 
 package com.soma.debugger.vo {
	import com.soma.core.interfaces.ISoma;
	import com.soma.core.interfaces.ISomaPluginVO;

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
	
	public class SomaDebuggerVO implements ISomaPluginVO {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		

		//------------------------------------
		// public properties
		//------------------------------------
		
		public var instance:ISoma;
		public var debuggerName:String;
		public var commands:Array;
		public var enableLog:Boolean;
		public var enableTrace:Boolean;
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		public function SomaDebuggerVO(instance:ISoma, debuggerName:String = null, commands:Array = null, enableLog:Boolean = true, enableTrace:Boolean = true) {
			if (instance == null) throw new Error("Error in " + this + " ISoma instance is null.");
			this.instance = instance;
			this.debuggerName = (debuggerName == null || debuggerName == "") ? "Soma::SomaDebugger" : debuggerName;
			this.commands = (commands == null) ? [] : commands;
			this.enableLog = enableLog;
			this.enableTrace = enableTrace;
		}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		
		
	}
}