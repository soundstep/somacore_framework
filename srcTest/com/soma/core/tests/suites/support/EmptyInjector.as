package com.soma.core.tests.suites.support {

	import uk.co.ziazoo.injector.IInjector;
	import com.soma.core.interfaces.ISomaInjector;

	/**
	 * @author Romuald Quantin (romu@soundstep.com)
	 */
	public class EmptyInjector implements ISomaInjector {

		public function createChildInjector():ISomaInjector {
			return null;
		}

		public function createInstance(classTarget:Class, asSingleton:Boolean = false, asEagerSingleton:Boolean = false, injectionName:String = null):Object {
			return null;
		}

		public function mapSingleton(classTarget:Class, asEagerSingleton:Boolean = false, injectionName:String = null):void {
		}

		public function mapTo(whenAskFor:Class, createClass:Class, injectionName:String = null):void {
		}

		public function mapToInstance(whenAskFor:Class, instanceTarget:Object, injectionName:String = null):void {
		}

		public function mapToFactory(whenAskFor:Class, createWithFactory:Class):void {
		}

		public function hasMapping(classTarget:Class, named:String = null):Boolean {
			return false;
		}

		public function getMappingName(classTarget:Class, injectionName:String = null):String {
			return null;
		}

		public function getMappingType(classTarget:Class, injectionName:String = null):Class {
			return null;
		}

		public function removeMapping(classTarget:Class, injectionName:String = null):void {
		}

		public function dispose():void {
		}

		public function get inj():IInjector {
			return null;
		}
	}
}
