package com.soma.core.interfaces {
	import flash.system.ApplicationDomain;
	/**
	 * @author Romuald Quantin
	 */
	public interface ISomaInjector {
		
		function createChildInjector():ISomaInjector;
		function getParentInjector():ISomaInjector;
		function createInstance(classTarget:Class):Object;
		function getInstance(classTarget:Class, name:String = ""):Object
		function injectInto(instance:Object):void;
		function mapSingleton(classTarget:Class, name:String = ""):void;
		function mapSingletonOf(whenAskFor:Class, useSingletonOf:Class, name:String = ""):void;
		function map(whenAskFor:Class, createClass:Class, name:String = ""):void;
		function mapToInstance(whenAskFor:Class, instance:Object, name:String = ""):void;
		function hasMapping(classTarget:Class, name:String = ""):Boolean;
		function removeMapping(classTarget:Class, name:String = ""):void;
		function getApplicationDomain():ApplicationDomain;
		function setApplicationDomain(value:ApplicationDomain):void;
		function dispose():void;
		
	}
}
