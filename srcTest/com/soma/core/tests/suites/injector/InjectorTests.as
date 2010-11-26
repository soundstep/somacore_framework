package com.soma.core.tests.suites.injector {

	import com.soma.core.Soma;
	import com.soma.core.di.SomaInjector;
	import com.soma.core.interfaces.ISomaInjector;

	import org.flexunit.asserts.assertNotNull;

	import mx.core.FlexGlobals;

	import flash.display.Stage;
	
	/**
	 * <b>Author:</b> Romuald Quantin - <a href="http://www.soundstep.com/" target="_blank">www.soundstep.com</a><br />
	 * <b>Class version:</b> 1.0<br />
	 * <b>Actionscript version:</b> 3.0<br />
	 * <b>Date:</b> Oct 6, 2010<br />
	 * @example
	 * <listing version="3.0"></listing>
	 */
	
	public class InjectorTests {
		
		private var _soma:Soma;		private var _injector:ISomaInjector;
		
		private static var _stage:Stage;
		
		[BeforeClass]
		public static function runBeforeClass():void {
			_stage = FlexGlobals.topLevelApplication.stage;
		}
		
		[AfterClass]
		public static function runAfterClass():void {
			_stage = null;
		} 
		
		[Before]
		public function runBefore():void {
			_soma = new Soma(_stage, SomaInjector);
			_injector = _soma.injector;
		}
		
		[After]
		public function runAfter():void {
			_soma.dispose();
			_soma = null;
		}
		
		[Test]
		public function testInjectorCreated():void {
			assertNotNull(_injector);
		}
	}
}