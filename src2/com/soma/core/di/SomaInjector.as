package com.soma.core.di {
	import com.soma.core.interfaces.ISomaInjector;
	import org.swiftsuspenders.Injector;

	import flash.system.ApplicationDomain;
	
	/**
	 * @author Romuald Quantin
	 */
	public class SomaInjector implements ISomaInjector {
		
		private var _injector:Injector;
		private var _parent:ISomaInjector;
		
		protected static const XML_CONFIG:XML =
			<types>
				<type name='com.soma.model::Model'>
					<field name='somaDispatcher'/>
				</type>
			</types>;
		
		public function SomaInjector() {
			initialize();
		}
		
		internal function initialize(specifiedInjector:Injector = null, parentInjector:ISomaInjector = null):ISomaInjector {
			if (_injector) dispose();
			if (!specifiedInjector) _injector = new Injector();
			else {
				_injector = specifiedInjector;
				if (parentInjector) _parent = parentInjector;
			}
			return this;
		}
		
		public function createChildInjector():ISomaInjector {
			return new SomaInjector().initialize(_injector.createChildInjector(), this);
		}
		
		public function getParentInjector():ISomaInjector {
			return _parent;
		}
		
		public function getInstance(classTarget:Class, name:String = ""):Object {
			return _injector.getInstance(classTarget, name);
		}
		
		public function createInstance(classTarget:Class):Object {
			return _injector.instantiate(classTarget);
		}
		
		public function injectInto(instance:Object):void {
			_injector.injectInto(instance);
		}

		public function mapSingleton(classTarget:Class, name:String = ""):void {
//			if (!hasMapping(classTarget)) {
//				mapTo(classTarget, classTarget);
//			}
			_injector.mapSingleton(classTarget, name);
		}
		
		public function mapSingletonOf(classTarget:Class, useSingletonOf:Class, name:String = ""):void {
			_injector.mapSingletonOf(classTarget, useSingletonOf, name);
		}
		
		public function mapTo(whenAskFor:Class, createClass:Class, name:String = ""):void {
			_injector.mapClass(whenAskFor, createClass, name);
		}
		
		public function mapToInstance(whenAskFor:Class, instance:Object, name:String = ""):void {
			_injector.mapValue(whenAskFor, instance, name);
		}
		
		public function hasMapping(classTarget:Class, name:String = ""):Boolean {
			return _injector.hasMapping(classTarget, name);
		}
		
		public function removeMapping(classTarget:Class, name:String = ""):void {
			_injector.unmap(classTarget, name);
		}

		public function getApplicationDomain():ApplicationDomain {
			return _injector.getApplicationDomain();
		}
		
		public function setApplicationDomain(value:ApplicationDomain):void {
			_injector.setApplicationDomain(value);
		}
		
		public function dispose():void {
			_injector = null;
			_parent = null;
		}
		
	}
}
