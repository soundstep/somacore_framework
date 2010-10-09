package com.soma.core.tests.suites.facade {	import com.soma.debugger.vo.SomaDebuggerVO;
	import com.soma.debugger.SomaDebugger;
	import flash.display.Sprite;
	import org.hamcrest.object.instanceOf;
	import org.flexunit.assertThat;
	import org.flexunit.asserts.assertNull;
	import com.soma.core.interfaces.ISomaPlugin;
	import org.flexunit.asserts.assertNotNull;
	import flash.display.Stage;
	import com.soma.core.interfaces.ISoma;
	import mx.core.FlexGlobals;
	import com.soma.core.Soma;
		/**	 * <b>Author:</b> Romuald Quantin - <a href="http://www.soundstep.com/" target="_blank">www.soundstep.com</a><br />	 * <b>Class version:</b> 1.0<br />	 * <b>Actionscript version:</b> 3.0<br />	 * <b>Date:</b> Oct 6, 2010<br />	 * @example	 * <listing version="3.0"></listing>	 */		public class FacadeTests {		
		private static var _stage:Stage;
		
		[BeforeClass]		public static function runBeforeClass():void {			_stage = FlexGlobals.topLevelApplication.stage;		}				[AfterClass]
		public static function runAfterClass():void {
			_stage = null;		} 				[Before]
		public function runBefore():void {
					}				[After]		public function runAfter():void {					}				[Test(expects="Error")]		public function testStageNullThrowError():void {			new Soma(null);		}				[Test]		public function testCreationSuccess():void {			assertNotNull(new Soma(_stage));		}				[Test]		public function testStageIsNotNull():void {			var soma:ISoma = new Soma(_stage);			assertNotNull(soma.stage);		}				[Test]		public function testModelsDictionary():void {			var soma:ISoma = new Soma(_stage);			assertNotNull(soma.models);		}				[Test]		public function testViewsDictionary():void {			var soma:ISoma = new Soma(_stage);			assertNotNull(soma.views);		}				[Test]		public function testWiresDictionary():void {			var soma:ISoma = new Soma(_stage);			assertNotNull(soma.wires);		}				[Test]		public function testController():void {			var soma:ISoma = new Soma(_stage);			assertNotNull(soma.controller);		}				[Test(expects="Error")]		public function testPluginBadInterface():void {			var soma:ISoma = new Soma(_stage);			var plugin:ISomaPlugin = soma.createPlugin(Sprite, null);			assertNull(plugin);		}				[Test(expects="Error")]		public function testPluginBadVO():void {			var soma:ISoma = new Soma(_stage);			var plugin:ISomaPlugin = soma.createPlugin(SomaDebugger, null);			assertNull(plugin);		}				[Test]		public function testPluginSuccess():void {			var soma:ISoma = new Soma(_stage);			var plugin:ISomaPlugin = soma.createPlugin(SomaDebugger, new SomaDebuggerVO(soma));			assertThat(plugin, instanceOf(SomaDebugger)); 			SomaDebugger(plugin).dispose();		}				[Test(expects="Error")]		public function testPluginFromClassBadInterface():void {			var soma:ISoma = new Soma(_stage);			var plugin:ISomaPlugin = soma.createPluginFromClassName("flash.display.Sprite", null);			assertNull(plugin);		}				[Test(expects="Error")]		public function testPluginFromClassBadVO():void {			var soma:ISoma = new Soma(_stage);			var plugin:ISomaPlugin = soma.createPluginFromClassName("com.soma.debugger.SomaDebugger", null);			assertNull(plugin);		}				[Test]		public function testPluginFromClassSuccess():void {			var soma:ISoma = new Soma(_stage);			var plugin:ISomaPlugin = soma.createPluginFromClassName("com.soma.debugger.SomaDebugger", new SomaDebuggerVO(soma));			assertThat(plugin, instanceOf(SomaDebugger));			SomaDebugger(plugin).dispose();		}			}}