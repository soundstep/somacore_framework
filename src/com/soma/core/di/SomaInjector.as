package com.soma.core.di {

	import uk.co.ziazoo.injector.impl.Injector;
	import uk.co.ziazoo.injector.IInjector;
	import com.soma.core.interfaces.ISomaInjector;
	/**
	 * @author Romuald Quantin
	 */
	public class SomaInjector implements ISomaInjector {
		
		private var _injector:IInjector;
		
		public function SomaInjector() {
			initialize();
		}
		
		internal function initialize(specifiedInjector:IInjector = null):ISomaInjector {
			if (!specifiedInjector) _injector = Injector.createInjector();
			else _injector = specifiedInjector;
			return this;
		}

		public function createChildInjector():ISomaInjector {
			return new SomaInjector().initialize(_injector.createChildInjector());
		}
		
		public function createInstance(classTarget:Class, asSingleton:Boolean = false, asEagerSingleton:Boolean = false):Object {
			if (asSingleton || asEagerSingleton) mapSingleton(classTarget, asEagerSingleton);
			return _injector.inject(classTarget);
		}
		
		public function mapSingleton(classTarget:Class, asEagerSingleton:Boolean = false, injectionName:String = null):void {
			if (!asEagerSingleton) _injector.map(classTarget).named(injectionName).asSingleton();
			else _injector.map(classTarget).named(injectionName).asEagerSingleton();
		}
		
		public function mapTo(whenAskFor:Class, createClass:Class, injectionName:String = null):void {
			_injector.map(whenAskFor).named(injectionName).to(createClass);
		}
		
		public function mapToInstance(whenAskFor:Class, instanceTarget:Object, injectionName:String = null):void {
			_injector.map(whenAskFor).named(injectionName).toInstance(instanceTarget);
		}
		
		public function mapToFactory(whenAskFor:Class, createWithFactory:Class):void {
			_injector.map(whenAskFor).toFactory(createWithFactory);
		}
		
		public function hasMapping(classTarget:Class, injectionName:String = null):Boolean {
			return _injector.hasMapping(classTarget, injectionName);
		}

		public function removeMapping(classTarget:Class, injectionName:String = null):void {
			_injector.removeMapping(classTarget, injectionName);
		}
		
	}
}
