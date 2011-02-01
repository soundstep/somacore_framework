package com.soma.core.interfaces {

	import com.soma.core.interfaces.IWire;

	/**
	 * <p><b>Author:</b> Romuald Quantin - <a href="http://www.soundstep.com/" target="_blank">www.soundstep.com</a></p>
	 * <p><b>Resources:</b> <a href="http://www.soundstep.com/downloads/somacore" target="_blank">http://www.soundstep.com/downloads/somacore</a></p>
	 * <p><b>Class version:</b> v2.0.0</p>
	 * <p><b>Actionscript version:</b> 3.0</p>
	 * <p><b>Copyright:</b>
	 * Mozilla Public License 1.1 (MPL 1.1)<br /> 
	 * <a href="http://www.opensource.org/licenses/mozilla1.1.php" target="_blank">http://www.opensource.org/licenses/mozilla1.1.php</a></p>
	 * The IMediator interface exposes the methods of a Mediator instance. 
	 * @see com.soma.core.mediator.Mediator
	 * @see com.soma.core.mediator.SomaMediators
	 */
	
	public interface IMediator extends IWire {
		
		/**
		 * View that has been mapped to the mediator instance.
		 */
		function get viewComponent():Object;
		function set viewComponent(value:Object):void;
		
	}
}
