package com.soma.core.interfaces {
	import flash.system.ApplicationDomain;
	
	/**
	 * <p><b>Author:</b> Romuald Quantin - <a href="http://www.soundstep.com/" target="_blank">www.soundstep.com</a></p>
	 * <p><b>Resources:</b> <a href="http://www.soundstep.com/downloads/somacore" target="_blank">http://www.soundstep.com/downloads/somacore</a></p>
	 * <p><b>Actionscript version:</b> 3.0</p>
	 * <p><b>Copyright:</b>
	 * Mozilla Public License 1.1 (MPL 1.1)<br /> 
	 * <a href="http://www.opensource.org/licenses/mozilla1.1.php" target="_blank">http://www.opensource.org/licenses/mozilla1.1.php</a></p>
	 * The ISomaReflector interface exposes the reflection methods used by the framework. 
	 * @see com.soma.core.di.SomaReflector
	 */
	
	public interface ISomaReflector {
		
		/**
		 * Indicates wether a Class or Class name extends or implements a given Class.
		 * @param classOrClassName A Class or a Class name.
		 * @param superclass A Class.
		 * @param application An ApplicationDomain.
		 * @return A Boolean.
		 */
		function classExtendsOrImplements(classOrClassName:Object, superclass:Class, application:ApplicationDomain = null):Boolean;
		/**
		 * Retrieves a Class.
		 * @param value Class, Class name or instance. 
		 * @param application An ApplicationDomain.
		 * @return A Class.
		 */
		function getClass(value:*, applicationDomain:ApplicationDomain = null):Class;
		/**
		 * Retrieves a fully qualified Class name.
		 * @param value Class, Class name or instance. 
		 * @param replaceColons
		 * @return A String.
		 */
		function getFQCN(value:*, replaceColons:Boolean = false):String;
		/**
		 * Destroys the reflector elements.
		 */
		function dispose():void;
		
	}
}
