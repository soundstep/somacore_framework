package com.soma.core.tests.suites.support {
	import flash.system.ApplicationDomain;
	import com.soma.core.interfaces.ISomaInjector;

	/**
	 * @author Romuald Quantin (romu@soundstep.com)
	 */
	public class EmptyInjector implements ISomaInjector {
		public function createChildInjector():ISomaInjector {
			return null;
		}

		public function getParentInjector():ISomaInjector {
			return null;
		}

		public function createInstance(classTarget:Class):Object {
			return null;
		}

		public function getInstance(classTarget:Class, name:String = ""):Object {
			return null;
		}

		public function injectInto(instance:Object):void {
		}

		public function mapSingleton(classTarget:Class, name:String = ""):void {
		}

		public function mapSingletonOf(classTarget:Class, useSingletonOf:Class, name:String = ""):void {
		}

		public function map(whenAskFor:Class, createClass:Class, name:String = ""):void {
		}

		public function mapToInstance(whenAskFor:Class, instance:Object, name:String = ""):void {
		}

		public function hasMapping(classTarget:Class, name:String = ""):Boolean {
			return false;
		}

		public function removeMapping(classTarget:Class, name:String = ""):void {
		}

		public function getApplicationDomain():ApplicationDomain {
			return null;
		}

		public function setApplicationDomain(value:ApplicationDomain):void {
		}

		public function dispose():void {
		}

		
		
	}
}
