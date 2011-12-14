package com.soma.core.di {
	import com.soma.core.interfaces.ISomaInjector;
	import org.swiftsuspenders.Injector;

	import flash.system.ApplicationDomain;
	
	/**
	 * <p><b>Author:</b> Romuald Quantin - <a href="http://www.soundstep.com/" target="_blank">www.soundstep.com</a></p>
	 * <p><b>Resources:</b> <a href="http://www.soundstep.com/downloads/somacore" target="_blank">http://www.soundstep.com/downloads/somacore</a></p>
	 * <p><b>Actionscript version:</b> 3.0</p>
	 * <p><b>Copyright:</b>
	 * Mozilla Public License 1.1 (MPL 1.1)<br /> 
	 * <a href="http://www.opensource.org/licenses/mozilla1.1.php" target="_blank">http://www.opensource.org/licenses/mozilla1.1.php</a></p>
	 * <p>The SomaInjector Class is an adapter for the injection library used by the framework: Swiftsuspenders.<br/>
	 * <a href="http://github.com/tschneidereit/SwiftSuspenders" target="_blank">http://github.com/tschneidereit/SwiftSuspenders</a>
	 * </p>
	 * <p>Injection is not enabled by default to keep the framework lighter in its basic use.<br/>
	 * To enable injection, The Soma Class constructor or its setup public method can receive a Class that must extends ISomaInjector.<br/>
	 * The default framework injector that can be used is SomaInjector.</p>
	 * <p>The SomaInjector instance is accessible using the injector property from the facade (your Soma instance), the wires, the mediators and the commands.</p>
	 * <p>The injector instance can be used directly and/or using metadata tags such as [Inject] or [PostConstruct], see the SwiftSuspenders documentation for more information: <a href="https://github.com/tschneidereit/SwiftSuspenders/blob/master/README.textile" target="_blank">https://github.com/tschneidereit/SwiftSuspenders</a></p>
	 * @example
	 * <listing version="3.0">
var application:ISoma = new Soma(stage, SomaInjector);
	 * </listing>
	 * <listing version="3.0">
var application:ISoma = new Soma();
application.setup(stage, SomaInjector);
	 * </listing>
	 * <listing version="3.0">
package  {
	import com.soma.core.interfaces.ISoma;
	import com.soma.core.di.SomaInjector;
	import flash.display.Sprite;
	
	public class Main extends Sprite {
		
		private var _app:ISoma;
		
		public function Main() {
			_app = new SomaApplication(stage, SomaInjector);
		}
		
	}
}
	 * </listing>
	 * <listing version="3.0">
package  {
	import com.soma.core.Soma;
	import com.soma.core.interfaces.ISoma;
	import flash.display.Stage;
	
	public class SomaApplication extends Soma implements ISoma {

		public function SomaApplication(stage:Stage, injectorClass:Class) {
			super(stage, injectorClass);
		}
		
	}
}
	 * </listing>
	 * <listing version="3.0">
package {
	public class Injectee {
		[Inject]
		public var myClass:MyClass;
		[PostConstruct]
		public funtion test():void {
			trace(myClass);
		}
	}
}
	 * </listing>
	 * <listing version="3.0">
injector.mapSingleton(MyClass);
injector.createInstance(Injectee);
	 * </listing>
	 * @see com.soma.core.interfaces.ISomaInjector
	 */
	
	public class SomaInjector implements ISomaInjector {
		
		/** @private */
		protected var _injector:Injector;
		/** @private */
		protected var _parent:ISomaInjector;
		
		/**
		 * Create an instance of the SomaInjector class.
		 * Automatically created by the framework when the injection is enabled and accessible using the injector property.
		 */
		public function SomaInjector() {
			initialize();
		}
		
		/** @private */
		internal function initialize(specifiedInjector:Injector = null, parentInjector:ISomaInjector = null):ISomaInjector {
			if (_injector) dispose();
			if (!specifiedInjector) _injector = new Injector();
			else {
				_injector = specifiedInjector;
				if (parentInjector) _parent = parentInjector;
			}
			return this;
		}
		
		/**
		 * Creates a child injector.
		 * The child injector inherits the rules of its parents.
		 * @return A ISomaInjector instance.
		 * @example
		 * <listing version="3.0">
var child:ISomaInjector = injector.createChildInjector();
		 * </listing>
		 */
		public function createChildInjector():ISomaInjector {
			return new SomaInjector().initialize(_injector.createChildInjector(), this);
		}
		
		/**
		 * Retrieves the injector parent if any.
		 * @return A ISomaInjector instance.
		 * @example
		 * <listing version="3.0">
var parent:ISomaInjector = injector.getParentInjector();
		 * </listing>
		 */
		public function getParentInjector():ISomaInjector {
			return _parent;
		}
		/**
		 * Retrieves or instantiates an instance of the given Class.
		 * This method needs a mapping rule, the instance can be a singleton or a new one.
		 * @param classTarget A Class.
		 * @param name Injection name.
		 * @return An instance of the Class target.
		 * @example
		 * <listing version="3.0">
injector.map(MyClass, MyClass);
var class1:MyClass = injector.getInstance(MyClass) as MyClass;
var class2:MyClass = injector.getInstance(MyClass) as MyClass;
		 * </listing>
		 */
		public function getInstance(classTarget:Class, name:String = ""):Object {
			return _injector.getInstance(classTarget, name);
		}
		
		/**
		 * Instantiates a new instance from a given class.
		 * This method will always creates a new instance, regardless of any singleton mapping.
		 * @param classTarget A Class.
		 * @return An instance of the Class target.
		 * @example
		 * <listing version="3.0">
injector.map(MyClass, MyClass);
var class1:MyClass = injector.createInstance(MyClass) as MyClass;
var class2:MyClass = injector.createInstance(MyClass) as MyClass;
		 * </listing>
		 */
		public function createInstance(classTarget:Class):Object {
			return _injector.instantiate(classTarget);
		}
		
		/**
		 * Performs injection into the given instance.
		 * @param instance An instance.
		 * @example
		 * <listing version="3.0">
package {
	public class Injectee {
		[Inject]
		public var myClass:MyClass;
	}
}
		 * </listing>
		 * <listing version="3.0">
injector.map(MyClass, MyClass);
var myClass:MyClass = injector.createInstance(MyClass) as MyClass;
injector.injectInto(myClass);
		 * </listing>
		 */
		public function injectInto(instance:Object):void {
			_injector.injectInto(instance);
		}
		
		/**
		 * Rule that defines the "classTarget" to be injected with always the same instance.
		 * @param classTarget A Class.
		 * @param name Injection name.
		 * @example
		 * <listing version="3.0">
injector.mapSingleton(MyClass, MyClass);
var myClass:MyClass = injector.getInstance(MyClass) as MyClass;
		 * </listing>
		 */
		public function mapSingleton(classTarget:Class, name:String = ""):void {
			_injector.mapSingleton(classTarget, name);
		}
		
		/**
		 * Rule that defines the "whenAskFor" (usually an interface) to be injected with the same instance "useSingletonOf".
		 * @param whenAskFor A Class.
		 * @param useSingletonOf A class.
		 * @param name Injection name.
		 * @example
		 * <listing version="3.0">
injector.mapSingletonOf(IMyClass, MyClass);
var myClass:MyClass = injector.getInstance(MyClass) as MyClass;
		 * </listing>
		 */
		public function mapSingletonOf(whenAskFor:Class, useSingletonOf:Class, name:String = ""):void {
			_injector.mapSingletonOf(whenAskFor, useSingletonOf, name);
		}
		
		/**
		 * Rule that defines the "whenAskFor" to be injected with an instance of the "createClass" Class.
		 * @param whenAskFor A Class.
		 * @param createClass A class.
		 * @param name Injection name.
		 * @example
		 * <listing version="3.0">
injector.map(MyClass, MyOtherClass)
var myOtherClass:MyOtherClass = injector.getInstance(MyClass) as MyOtherClass;
		 * </listing>
		 */
		public function map(whenAskFor:Class, createClass:Class, name:String = ""):void {
			_injector.mapClass(whenAskFor, createClass, name);
		}
		
		/**
		 * Rule that defines the "whenAskFor" to be injected the given instance.
		 * @param whenAskFor A Class.
		 * @param instance An instance.
		 * @param name Injection name.
		 * @example
		 * <listing version="3.0">
var myClass:MyClass = new MyClass();
injector.mapToInstance(MyClass, myClass)
var myClassSameInstance:MyClass = injector.getInstance(MyClass) as MyClass;
		 * </listing>
		 */
		public function mapToInstance(whenAskFor:Class, instance:Object, name:String = ""):void {
			_injector.mapValue(whenAskFor, instance, name);
		}
		
		/**
		 * Indicates whether a mapping rule exists for the given Class.
		 * @param classTarget A Class.
		 * @param name Injection name.
		 * @return A Boolean.
		 * @example
		 * <listing version="3.0">
injector.map(MyClass, MyClass)
var value:Boolean = injector.hasMapping(MyClass); // return true
		 * </listing>
		 */
		public function hasMapping(classTarget:Class, name:String = ""):Boolean {
			return _injector.hasMapping(classTarget, name);
		}
		
		/**
		 * Removes a mapping rule exists for the given Class.
		 * @param classTarget A Class.
		 * @param name Injection name.
		 * @return A Boolean.
		 * @example
		 * <listing version="3.0">
injector.map(MyClass, MyClass)
var value:Boolean = injector.hasMapping(MyClass); // return true
injector.removeMapping(MyClass);
value = injector.hasMapping(MyClass); // return false
		 * </listing>
		 */
		public function removeMapping(classTarget:Class, name:String = ""):void {
			_injector.unmap(classTarget, name);
		}
		
		/**
		 * ApplicationDomain in use in the injector.
		 * @param classTarget A Class.
		 * @param name Injection name.
		 * @return A Boolean.
		 */
		public function get applicationDomain():ApplicationDomain {
			return _injector.getApplicationDomain();
		}
		
		public function set applicationDomain(value:ApplicationDomain):void {
			_injector.setApplicationDomain(value);
		}
		
		/**
		 * Destroys the injector elements.
		 */
		public function dispose():void {
			_injector = null;
			_parent = null;
		}
		
	}
}
