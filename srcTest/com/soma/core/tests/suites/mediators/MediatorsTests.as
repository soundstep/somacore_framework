package com.soma.core.tests.suites.mediators {

	import org.flexunit.asserts.assertFalse;
	import com.soma.core.Soma;
	import com.soma.core.di.SomaInjector;
	import com.soma.core.interfaces.ISoma;
	import com.soma.core.tests.suites.support.EmptyView;
	import com.soma.core.tests.suites.support.EmptyViewMediator;

	import org.flexunit.asserts.assertTrue;

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
	
	public class MediatorsTests {
		
		private var _soma:ISoma;		private var _somaInjection:ISoma;
		
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
			_soma = new Soma(_stage);
			_somaInjection = new Soma(_stage, SomaInjector);
		}
		
		[After]
		public function runAfter():void {
			_soma.dispose();
			_soma = null;
			_somaInjection.dispose();
			_somaInjection = null;
		}
		
		[Test]
		public function testIsMapped():void {
			_soma.mediators.mapView(EmptyView, EmptyViewMediator);
			assertTrue(_soma.mediators.isMapped(EmptyView));
		}
		
		[Test]
		public function testIsNotMapped():void {
			assertFalse(_soma.mediators.isMapped(EmptyView));
		}
		

	}
}