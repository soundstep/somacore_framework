package com.soma.core.interfaces {
	import flash.system.ApplicationDomain;
	/**
	 * @author Romuald Quantin
	 */
	public interface ISomaInjector {
		
		/**
		 * Creates a child injector.
		 * The child injector inherits the rules of its parents.
		 * @return A ISomaInjector instance.
		 */
		function createChildInjector():ISomaInjector;
		/**
		 * Retrieves the injector parent if any.
		 * @return A ISomaInjector instance.
		 */
		function getParentInjector():ISomaInjector;
		/**
		 * Instantiates a new instance from a given class.
		 * This method will always creates a new instance, regardless of any singleton mapping.
		 * @param classTarget A Class.
		 * @return An instance of the Class target.
		 */
		function createInstance(classTarget:Class):Object;
		/**
		 * Retrieves or instantiates an instance of the given Class.
		 * This method needs a mapping rule, the instance can be a singleton or a new one.
		 * @param classTarget A Class.
		 * @param name Injection name.
		 * @return An instance of the Class target.
		 */
		function getInstance(classTarget:Class, name:String = ""):Object
		/**
		 * Performs injection into the given instance.
		 * @param instance An instance.
		 */
		function injectInto(instance:Object):void;
		/**
		 * Rule that defines the "classTarget" to be injected with always the same instance.
		 * @param classTarget A Class.
		 * @param name Injection name.
		 */
		function mapSingleton(classTarget:Class, name:String = ""):void;
		/**
		 * Rule that defines the "whenAskFor" (usually an interface) to be injected with the same instance "useSingletonOf".
		 * @param whenAskFor A Class.
		 * @param useSingletonOf A class.
		 * @param name Injection name.
		 */
		function mapSingletonOf(whenAskFor:Class, useSingletonOf:Class, name:String = ""):void;
		/**
		 * Rule that defines the "whenAskFor" to be injected with an instance of the "createClass" Class.
		 * @param whenAskFor A Class.
		 * @param createClass A class.
		 * @param name Injection name.
		 */
		function map(whenAskFor:Class, createClass:Class, name:String = ""):void;
		/**
		 * Rule that defines the "whenAskFor" to be injected the given instance.
		 * @param whenAskFor A Class.
		 * @param instance An instance.
		 * @param name Injection name.
		 */
		function mapToInstance(whenAskFor:Class, instance:Object, name:String = ""):void;
		/**
		 * Indicates wether a mapping rule exists for the given Class.
		 * @param classTarget A Class.
		 * @param name Injection name.
		 * @return A Boolean.
		 */
		function hasMapping(classTarget:Class, name:String = ""):Boolean;
		/**
		 * Removes a mapping rule exists for the given Class.
		 * @param classTarget A Class.
		 * @param name Injection name.
		 * @return A Boolean.
		 */
		function removeMapping(classTarget:Class, name:String = ""):void;
		/**
		 * ApplicationDomain in use in the injector.
		 * @param classTarget A Class.
		 * @param name Injection name.
		 * @return A Boolean.
		 */
		function get applicationDomain():ApplicationDomain;
		function set applicationDomain(value:ApplicationDomain):void;
		/**
		 * Destroys the injector elements.
		 */
		function dispose():void;
		
	}
}
