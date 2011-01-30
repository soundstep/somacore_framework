package com.soma.core.interfaces {
	import flash.system.ApplicationDomain;
	/**
	 * @author romuald
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
