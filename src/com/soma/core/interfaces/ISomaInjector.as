package com.soma.core.interfaces {

	/**
	 * @author Romuald Quantin
	 */
	public interface ISomaInjector {
		function createChildInjector():ISomaInjector;
		function createInstance(classTarget:Class, asSingleton:Boolean = false, asEagerSingleton:Boolean = false):Object;
		function mapSingleton(classTarget:Class, asEagerSingleton:Boolean = false, injectionName:String = null):void;
		function mapTo(whenAskFor:Class, createClass:Class, injectionName:String = null):void;
		function mapToInstance(whenAskFor:Class, instanceTarget:Object, injectionName:String = null):void;
		function mapToFactory(whenAskFor:Class, createWithFactory:Class):void;
		function hasMapping(classTarget:Class, named:String = null):Boolean;
		function removeMapping(classTarget:Class, injectionName:String = null):void
	}
}
