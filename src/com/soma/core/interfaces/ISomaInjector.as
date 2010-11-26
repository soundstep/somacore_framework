package com.soma.core.interfaces {
	import uk.co.ziazoo.injector.IInjector;

	/**
	 * @author Romuald Quantin
	 */
	public interface ISomaInjector {
		function createChildInjector():ISomaInjector;
		function createInstance(classTarget:Class, asSingleton:Boolean = false, asEagerSingleton:Boolean = false, injectionName:String = null):Object;
		function mapSingleton(classTarget:Class, asEagerSingleton:Boolean = false, injectionName:String = null):void;
		function mapTo(whenAskFor:Class, createClass:Class, injectionName:String = null):void;
		function mapToInstance(whenAskFor:Class, instanceTarget:Object, injectionName:String = null):void;
		function mapToFactory(whenAskFor:Class, createWithFactory:Class):void;
		function hasMapping(classTarget:Class, named:String = null):Boolean;
		function getMappingName(classTarget:Class, injectionName:String = null):String;
		function getMappingType(classTarget:Class, injectionName:String = null):Class;		function removeMapping(classTarget:Class, injectionName:String = null):void
		function dispose():void;
		
		function get inj():IInjector;
	}
}
