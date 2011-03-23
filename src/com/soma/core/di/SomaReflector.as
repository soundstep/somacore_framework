package com.soma.core.di {
	import com.soma.core.interfaces.ISomaReflector;
	import org.swiftsuspenders.Reflector;

	/**
	 * <p><b>Author:</b> Romuald Quantin - <a href="http://www.soundstep.com/" target="_blank">www.soundstep.com</a></p>
	 * <p><b>Resources:</b> <a href="http://www.soundstep.com/downloads/somacore" target="_blank">http://www.soundstep.com/downloads/somacore</a></p>
	 * <p><b>Actionscript version:</b> 3.0</p>
	 * <p><b>Copyright:</b>
	 * Mozilla Public License 1.1 (MPL 1.1)<br /> 
	 * <a href="http://www.opensource.org/licenses/mozilla1.1.php" target="_blank">http://www.opensource.org/licenses/mozilla1.1.php</a></p>
	 * <p>The SomaReflector Class is an adapter for the reflection library used by the framework: Swiftsuspenders.<br/>
	 * <a href="http://github.com/tschneidereit/SwiftSuspenders" target="_blank">http://github.com/tschneidereit/SwiftSuspenders</a>
	 * </p>
	 * @see com.soma.core.interfaces.ISomaReflector
	 */
	
	public class SomaReflector extends Reflector implements ISomaReflector {
		
		/**
		 * Destroys the reflector elements.
		 */
		public function dispose():void {
		}
		
	}
}
