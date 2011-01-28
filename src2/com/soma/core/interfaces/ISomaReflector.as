package com.soma.core.interfaces {
	import flash.system.ApplicationDomain;
	/**
	 * @author romuald
	 */
	public interface ISomaReflector {
		
		function classExtendsOrImplements(classOrClassName:Object, superclass:Class, application:ApplicationDomain = null):Boolean;
		function getClass(value:*, applicationDomain:ApplicationDomain = null):Class;
		function getFQCN(value:*, replaceColons:Boolean = false):String;
		function dispose():void;
		
	}
}
