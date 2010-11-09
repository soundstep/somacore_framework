package com.soma.core.tests.suites.support {
	import flash.events.IEventDispatcher;
	import flash.events.Event;
	import com.soma.core.interfaces.IModel;
	import com.soma.core.model.Model;
	
	/**
	 * <b>Author:</b> Romuald Quantin - <a href="http://www.soundstep.com/" target="_blank">www.soundstep.com</a><br />
	 * <b>Class version:</b> 1.0<br />
	 * <b>Actionscript version:</b> 3.0<br />
	 * <b>Date:</b> Oct 9, 2010<br />
	 * @example
	 * <listing version="3.0"></listing>
	 */
	
	public class EmptyModel extends Model implements IModel {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		

		//------------------------------------
		// public properties
		//------------------------------------
		
		public static const NAME:String = "EmptyModel";
		
		public static const EVENT_INITIALIZED:String = "EmptyModel::Event.EVENT_INITIALIZED";
		public static const EVENT_DISPOSED:String = "EmptyModel::Event.EVENT_DISPOSED";
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		public function EmptyModel(data:Object = null, dispatcher:IEventDispatcher = null) {
			super(NAME, data, dispatcher);
		}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		override public function initialize():void {
			dispatchEvent(new Event(EVENT_INITIALIZED));
		}
		
		override public function dispose():void {
			dispatchEvent(new Event(EVENT_DISPOSED));
		}
		
		//
		// PUBLIC
		//________________________________________________________________________________________________

		
		
	}
}