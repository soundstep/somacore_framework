package com.soma.core.tests.suites.injector {

	import com.soma.core.Soma;
	import com.soma.core.di.SomaInjector;
	import com.soma.core.interfaces.ISoma;
	import com.soma.core.interfaces.ISomaInjector;
	import com.soma.core.tests.suites.support.EmptyInjector;
	import com.soma.core.tests.suites.support.EmptyView;

	import org.flexunit.assertThat;
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertNotNull;
	import org.flexunit.asserts.assertNull;
	import org.flexunit.asserts.assertTrue;
	import org.hamcrest.object.instanceOf;

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
		public function testInjectorIsNull():void {
			var s:ISoma = new Soma(_stage);
			assertNull(s.injector);
			s.dispose();
		}
		
		[Test(expects="Error")]
		public function testInjectorBadClass():void {
			var s:ISoma = new Soma(_stage, Object);
			assertNull(s.injector);
			s.dispose();
		}
		
		[Test]
		public function testInjectorCreated():void {
			assertNotNull(_injector);
		}
		
		[Test]
		public function testCustomInjectorCreated():void {
			var s:ISoma = new Soma(_stage, EmptyInjector);
			assertNotNull(s.injector);
			s.dispose();
		}
		
		[Test]
		public function testCreateChildInjector():void {
			// TODO (also try to switch the injector of the mediator to a child injector)
		}
		
		[Test]
		public function testCreateInstance():void {
			var view:EmptyView = _injector.createInstance(EmptyView) as EmptyView;
			assertNotNull(view);
			assertThat(view, instanceOf(EmptyView));
		}
		
		[Test]
		public function testCreateInstanceNamed():void {
			var view:EmptyView = _injector.createInstance(EmptyView, false, false, "injection name") as EmptyView;
			assertNotNull(view);
			assertThat(view, instanceOf(EmptyView));
		}
		
		[Test]
		public function testCreateTwoInstances():void {
			var view:EmptyView = _injector.createInstance(EmptyView) as EmptyView;
			var view2:EmptyView = _injector.createInstance(EmptyView) as EmptyView;
			assertTrue(view != view2);
		}
		
		[Test]
		public function testCreateSingleton():void {
			var view:EmptyView = _injector.createInstance(EmptyView, true) as EmptyView;
			var view2:EmptyView = _injector.createInstance(EmptyView) as EmptyView;
			assertEquals(view, view2);
		}
		
		[Test]
		public function testCreateSingletonNamed():void {
			var view:EmptyView = _injector.createInstance(EmptyView, true, false, "injection name") as EmptyView;
			var view2:EmptyView = _injector.createInstance(EmptyView, false, false, "injection name") as EmptyView;
			assertEquals(view, view2);
		}
		
		[Test]
		public function testCreateEagerSingleton():void {
			var view:EmptyView = _injector.createInstance(EmptyView, false, true) as EmptyView;
			var view2:EmptyView = _injector.createInstance(EmptyView) as EmptyView;
			assertEquals(view, view2);
		}
		
		[Test]
		public function testCreateEagerSingletonNamed():void {
			var view:EmptyView = _injector.createInstance(EmptyView, true, true, "injection name") as EmptyView;
			var view2:EmptyView = _injector.createInstance(EmptyView, false, false, "injection name") as EmptyView;
			assertEquals(view, view2);
		}
		
		[Test]
		public function testMapSingleton():void {
			_injector.mapSingleton(EmptyView);
			var view:EmptyView = _injector.createInstance(EmptyView) as EmptyView;
			var view2:EmptyView = _injector.createInstance(EmptyView) as EmptyView;
			assertEquals(view, view2);
		}
		
		[Test]
		public function testMapSingletonNamed():void {
			_injector.mapSingleton(EmptyView, false, "injection name");
			var view:EmptyView = _injector.createInstance(EmptyView, false, false, "injection name") as EmptyView;
			var view2:EmptyView = _injector.createInstance(EmptyView, false, false, "injection name") as EmptyView;
			assertEquals(view, view2);
		}
		
		[Test]
		public function testMapEagerSingleton():void {
			_injector.mapSingleton(EmptyView, true);
			var view:EmptyView = _injector.createInstance(EmptyView) as EmptyView;
			var view2:EmptyView = _injector.createInstance(EmptyView) as EmptyView;
			assertEquals(view, view2);
		}
		
		[Test]
		public function testMapEagerSingletonNamed():void {
			_injector.mapSingleton(EmptyView, true, "injection name");
			var view:EmptyView = _injector.createInstance(EmptyView, false, false, "injection name") as EmptyView;
			var view2:EmptyView = _injector.createInstance(EmptyView, false, false, "injection name") as EmptyView;
			assertEquals(view, view2);
		}
		
//		[Test]
//		public function testInjectorDispose():void {
//			_injector.mapTo(EmptyView, EmptyViewMediator);
//			trace(_injector.hasMapping(EmptyView))
//			_injector.dispose();
//			trace(_injector.hasMapping(EmptyView))
//			assertFalse(_injector.hasMapping(EmptyView));
			// TODO check dispose
//		}
		
		[Test]
		public function testGetMappingName():void {
//			_injector.inj.map(EmptyView).named("injection name").to(EmptyViewMediator);
//			var map:IMapping = _injector.inj.getMapping(EmptyView, "injection name");
//			trace("£££", map.name, map.type)
			
//			_injector.map(String).named("gna").to(String);
//			trace(0, _injector.getMapping(String, "gna").name)
			
			
//			_injector.mapTo(IMediator, EmptyViewMediator);
//			trace("###", _injector.getMappingName(IMediator, "injection name"))
//			assertEquals(_injector.getMappingName(EmptyView), "injection name")
			// TODO: check get mapping name and type as it doesn't make sense because you always need the name
		}
		
	}
}