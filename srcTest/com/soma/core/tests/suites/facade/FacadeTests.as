package com.soma.core.tests.suites.facade {

	import com.soma.core.di.SomaInjector;
	import org.hamcrest.object.instanceOf;
	import org.flexunit.assertThat;
	import com.soma.debugger.vo.SomaDebuggerVO;
	import flash.display.Sprite;
	import com.soma.debugger.SomaDebugger;
	import org.flexunit.asserts.assertNull;
	import com.soma.core.interfaces.ISomaPlugin;
	import org.flexunit.asserts.assertNotNull;
	import flash.display.Stage;
	import com.soma.core.interfaces.ISoma;
	import mx.core.FlexGlobals;
	import com.soma.core.Soma;
		/**	 * <b>Author:</b> Romuald Quantin - <a href="http://www.soundstep.com/" target="_blank">www.soundstep.com</a><br />	 * <b>Class version:</b> 1.0<br />	 * <b>Actionscript version:</b> 3.0<br />	 * <b>Date:</b> Oct 6, 2010<br />	 * @example	 * <listing version="3.0"></listing>	 */		public class FacadeTests {		
		private var _soma:ISoma;		
		private static var _stage:Stage;
		
		[BeforeClass]		public static function runBeforeClass():void {			_stage = FlexGlobals.topLevelApplication.stage;		}				[AfterClass]
		public static function runAfterClass():void {
			_stage = null;		} 				[Before]
		public function runBefore():void {
					}				[After]		public function runAfter():void {			if (_soma) {				_soma.dispose();				_soma = null;			}		}				private function checkCoreComponentsFailed():void {
			assertNull(_soma.stage);
			assertNull(_soma.models);
			assertNull(_soma.controller);
			assertNull(_soma.views);
			assertNull(_soma.mediators);
		}
		
		private function checkCoreComponentsSucess():void {
			assertNotNull(_soma.stage);
			assertNotNull(_soma.models);
			assertNotNull(_soma.controller);
			assertNotNull(_soma.views);
			assertNotNull(_soma.mediators);
		}
		
		[Test]
		public function testCreationSuccess():void {
			_soma = new Soma(_stage);
			checkCoreComponentsSucess();
		}
		
		[Test]
		public function testCreationFailing():void {
			_soma = new Soma();
			checkCoreComponentsFailed();
		}
		
		[Test]
		public function testCreationSetupSuccess():void {
			_soma = new Soma();
			_soma.setup(_stage);
			checkCoreComponentsSucess();
		}

		[Test]
		public function testCreationSetupFailing():void {
			_soma = new Soma();
			_soma.setup(null);
			checkCoreComponentsFailed();
		}

		[Test]
		public function testStageIsNotNull():void {
			_soma = new Soma(_stage);
			assertNotNull(_soma.stage);
		}
		
		[Test]
		public function testSetupStageIsNotNull():void {
			_soma = new Soma();
			_soma.setup(_stage);
			assertNotNull(_soma.stage);
		}
		
		[Test]
		public function testInjectorIsNotNull():void {
			_soma = new Soma(_stage, SomaInjector);
			assertNotNull(_soma.injector);
		}
		
		[Test]
		public function testNoStageInjectorIsNotNull():void {
			_soma = new Soma(null, SomaInjector);
			assertNotNull(_soma.injector);
		}
		
		[Test]
		public function testSetupInjectorIsNotNull():void {
			_soma = new Soma();
			_soma.setup(_stage, SomaInjector);
			assertNotNull(_soma.injector);
		}
		
		[Test]
		public function testSetupNoStageInjectorIsNotNull():void {
			_soma = new Soma();
			_soma.setup(null, SomaInjector);
			assertNotNull(_soma.injector);
		}
		
		[Test]		public function testModelsDictionary():void {			_soma = new Soma(_stage);			assertNotNull(_soma.models);		}				[Test]		public function testViewsDictionary():void {			_soma = new Soma(_stage);			assertNotNull(_soma.views);		}				[Test]		public function testWiresDictionary():void {			_soma = new Soma(_stage);			assertNotNull(_soma.wires);		}				[Test]
		public function testController():void {
			_soma = new Soma(_stage);
			assertNotNull(_soma.controller);
		}
		
		[Test]
		public function testMediators():void {
			_soma = new Soma(_stage);
			assertNotNull(_soma.mediators);
		}
		
		[Test(expects="Error")]		public function testPluginBadInterface():void {			_soma = new Soma(_stage);			var plugin:ISomaPlugin = _soma.createPlugin(Sprite, null);			assertNull(plugin);		}				[Test(expects="Error")]		public function testPluginBadVO():void {			_soma = new Soma(_stage);			var plugin:ISomaPlugin = _soma.createPlugin(SomaDebugger, null);			assertNull(plugin);		}				[Test]		public function testPluginSuccess():void {			_soma = new Soma(_stage);			var plugin:ISomaPlugin = _soma.createPlugin(SomaDebugger, new SomaDebuggerVO(_soma));			assertThat(plugin, instanceOf(SomaDebugger));			plugin.dispose();			plugin = null;		}				[Test(expects="Error")]		public function testPluginFromClassBadInterface():void {			_soma = new Soma(_stage);			var plugin:ISomaPlugin = _soma.createPluginFromClassName("flash.display.Sprite", null);			assertNull(plugin);		}				[Test(expects="Error")]		public function testPluginFromClassBadVO():void {			_soma = new Soma(_stage);			var plugin:ISomaPlugin = _soma.createPluginFromClassName("com.soma.debugger.SomaDebugger", null);			assertNull(plugin);		}				[Test]		public function testPluginFromClassSuccess():void {			_soma = new Soma(_stage);			var plugin:ISomaPlugin = _soma.createPluginFromClassName("com.soma.debugger.SomaDebugger", new SomaDebuggerVO(_soma));			assertThat(plugin, instanceOf(SomaDebugger));			plugin.dispose();			plugin = null;		}			}}