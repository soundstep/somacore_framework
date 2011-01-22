package com.soma.core.demo.di.views {
	import flash.events.IEventDispatcher;
	import com.soma.core.interfaces.ISoma;
	/**
	 * @author romuald
	 */
	
	
	
	public class TestISoma {
		
		private var _dispatcher:IEventDispatcher;
		private var _soma:ISoma;
		
//		[Inject(name="somaInstance")]
//		public var soma:ISoma;
//		
//		[Inject(name="somaDispatcher")]
//		public var dispatcher:IEventDispatcher;
		
		[Inject(name="somaInstance")]
		public function set soma(value:ISoma):void {
			_soma = value;
		}
		
		[Inject(name="somaDispatcher")]
		public function set dispatcher(value:IEventDispatcher):void {
			_dispatcher = value;
		}
		
		[PostConstruct]
		public function test():void {
			trace("soma2: ", _soma);
			trace("dispatcher2: ", _dispatcher);
		}
		
		public function TestISoma() {
			
		}
		
		
	}
}
