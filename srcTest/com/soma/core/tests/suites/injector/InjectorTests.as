package com.soma.core.tests.suites.injector {
	import flash.system.ApplicationDomain;
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertTrue;
	import org.flexunit.asserts.assertEquals;
	import com.soma.core.Soma;
	import com.soma.core.di.SomaInjector;
	import com.soma.core.interfaces.ISoma;
	import com.soma.core.interfaces.ISomaInjector;
	import com.soma.core.tests.suites.support.EmptyInjector;
	import com.soma.core.tests.suites.support.EmptyView;

	import org.flexunit.asserts.assertNotNull;
	import org.flexunit.asserts.assertNull;
	import org.hamcrest.assertThat;
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
		
		private var _soma:Soma;		
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
			assertNotNull(_soma.injector);
		}
		
		[Test]
		public function testCustomInjectorCreated():void {
			var s:ISoma = new Soma(_stage, EmptyInjector);
			assertNotNull(s.injector);
			s.dispose();
		}
		
		[Test]
		public function testCreateChildInjector():void {
			var child:ISomaInjector = _soma.injector.createChildInjector();
			assertNotNull(child);
			assertThat(child, instanceOf(ISomaInjector));
		}
		
		[Test]
		public function testChildInjectorParent():void {
			var child:ISomaInjector = _soma.injector.createChildInjector();
			assertNotNull(child.getParentInjector());
			assertThat(child.getParentInjector(), instanceOf(ISomaInjector));
			assertEquals(child.getParentInjector(), _soma.injector);
		}
		
		[Test]
		public function testCreateInstance():void {
			var view:EmptyView = _soma.injector.createInstance(EmptyView) as EmptyView;
			assertNotNull(view);
			assertThat(view, instanceOf(EmptyView));
		}
		
		[Test]
		public function testChildCreateInstance():void {
			var child:ISomaInjector = _soma.injector.createChildInjector();
			var view:EmptyView = child.createInstance(EmptyView) as EmptyView;
			assertNotNull(view);
			assertThat(view, instanceOf(EmptyView));
		}
		
		[Test(expects="Error")]
		public function testGetInstanceErrorNoMapping():void {
			var view:EmptyView = _soma.injector.getInstance(EmptyView) as EmptyView;
			assertThat(view, instanceOf(EmptyView));
		}
		
		[Test(expects="Error")]
		public function testChildGetInstanceErrorNoMapping():void {
			var child:ISomaInjector = _soma.injector.createChildInjector();
			var view:EmptyView = child.getInstance(EmptyView) as EmptyView;
			assertThat(view, instanceOf(EmptyView));
		}
		
		[Test]
		public function testGetInstanceSucess():void {
			_soma.injector.mapTo(EmptyView, EmptyView);
			var view:EmptyView = _soma.injector.getInstance(EmptyView) as EmptyView;
			assertNotNull(view);
			assertThat(view, instanceOf(EmptyView));
		}
		
		[Test]
		public function testChildGetInstanceSucessFromParentMapping():void {
			var child:ISomaInjector = _soma.injector.createChildInjector();
			_soma.injector.mapTo(EmptyView, EmptyView);
			var view:EmptyView = child.getInstance(EmptyView) as EmptyView;
			assertNotNull(view);
			assertThat(view, instanceOf(EmptyView));
		}
		
		[Test]
		public function testChildGetInstanceSucessFromChildMapping():void {
			var child:ISomaInjector = _soma.injector.createChildInjector();
			child.mapTo(EmptyView, EmptyView);
			var view:EmptyView = child.getInstance(EmptyView) as EmptyView;
			assertNotNull(view);
			assertThat(view, instanceOf(EmptyView));
		}
		
		[Test(expects="Error")]
		public function testGetInstanceSucessFromChildMapping():void {
			var child:ISomaInjector = _soma.injector.createChildInjector();
			child.mapTo(EmptyView, EmptyView);
			var view:EmptyView = _soma.injector.getInstance(EmptyView) as EmptyView;
			assertThat(view, instanceOf(EmptyView));
		}
		
		[Test(expects="Error")]
		public function testGetInstanceNamedError():void {
			_soma.injector.mapTo(EmptyView, EmptyView);
			var view:EmptyView = _soma.injector.getInstance(EmptyView, "injection name") as EmptyView;
			assertNotNull(view);
			assertThat(view, instanceOf(EmptyView));
		}
		
		[Test]
		public function testGetInstanceNamedSuccess():void {
			_soma.injector.mapTo(EmptyView, EmptyView, "injection name");
			var view:EmptyView = _soma.injector.getInstance(EmptyView, "injection name") as EmptyView;
			assertNotNull(view);
			assertThat(view, instanceOf(EmptyView));
		}
		
		[Test]
		public function testChildGetInstanceNamedSuccess():void {
			var child:ISomaInjector = _soma.injector.createChildInjector();
			_soma.injector.mapTo(EmptyView, EmptyView, "injection name");
			var view:EmptyView = child.getInstance(EmptyView, "injection name") as EmptyView;
			assertNotNull(view);
			assertThat(view, instanceOf(EmptyView));
		}
		
		[Test]
		public function testCreateTwoInstances():void {
			var view1:EmptyView = _soma.injector.createInstance(EmptyView) as EmptyView;
			var view2:EmptyView = _soma.injector.createInstance(EmptyView) as EmptyView;
			assertNotNull(view1);
			assertNotNull(view2);
			assertTrue(view1 != view2);
		}
		
		[Test]
		public function testGetTwoInstances():void {
			_soma.injector.mapTo(EmptyView, EmptyView);
			var view1:EmptyView = _soma.injector.getInstance(EmptyView) as EmptyView;
			var view2:EmptyView = _soma.injector.getInstance(EmptyView) as EmptyView;
			assertNotNull(view1);
			assertNotNull(view2);
			assertTrue(view1 != view2);
		}
		
		[Test]
		public function testGetSingleton():void {
			_soma.injector.mapSingleton(EmptyView);
			var view1:EmptyView = _soma.injector.getInstance(EmptyView) as EmptyView;
			var view2:EmptyView = _soma.injector.getInstance(EmptyView) as EmptyView;
			assertNotNull(view1);
			assertNotNull(view2);
			assertEquals(view1, view2);
		}
		
		[Test(expects="Error")]
		public function testCreateSingleton():void {
			_soma.injector.mapSingleton(EmptyView);
			var view1:EmptyView = _soma.injector.createInstance(EmptyView) as EmptyView;
			var view2:EmptyView = _soma.injector.createInstance(EmptyView) as EmptyView;
			assertEquals(view1, view2);
		}
		
		[Test]
		public function testCreateSingletonNamed():void {
			_soma.injector.mapSingleton(EmptyView, "injection name");
			_soma.injector.mapSingleton(EmptyView);
			var view1:EmptyView = _soma.injector.getInstance(EmptyView, "injection name") as EmptyView;
			var view2:EmptyView = _soma.injector.getInstance(EmptyView, "injection name") as EmptyView;
			var view3:EmptyView = _soma.injector.getInstance(EmptyView) as EmptyView;
			assertNotNull(view1);
			assertNotNull(view2);
			assertNotNull(view3);
			assertEquals(view1, view2);
			assertTrue(view1 != view3);
			assertTrue(view2 != view3);
		}
		
		[Test]
		public function testHasMapping():void {
			_soma.injector.mapSingleton(EmptyView);
			assertTrue(_soma.injector.hasMapping(EmptyView));
		}
		
		[Test]
		public function testHasMappingNamed():void {
			_soma.injector.mapSingleton(EmptyView, "injection name");
			assertTrue(_soma.injector.hasMapping(EmptyView, "injection name"));
		}
		
		[Test]
		public function testChildHasMapping():void {
			var child:ISomaInjector = _soma.injector.createChildInjector();
			_soma.injector.mapSingleton(EmptyView);
			assertTrue(child.hasMapping(EmptyView));
		}
		
		[Test]
		public function testChildHasMappingNamed():void {
			var child:ISomaInjector = _soma.injector.createChildInjector();
			_soma.injector.mapSingleton(EmptyView, "injection name");
			assertTrue(child.hasMapping(EmptyView, "injection name"));
		}
		
		[Test(expects="Error")]
		public function testParentHasChildMapping():void {
			var child:ISomaInjector = _soma.injector.createChildInjector();
			child.mapSingleton(EmptyView);
			assertTrue(_soma.injector.hasMapping(EmptyView));
		}
		
		[Test(expects="Error")]
		public function testParentHasChildMappingNamed():void {
			var child:ISomaInjector = _soma.injector.createChildInjector();
			child.mapSingleton(EmptyView, "injection name");
			assertTrue(_soma.injector.hasMapping(EmptyView, "injection name"));
		}
		
		[Test]
		public function testRemoveMapping():void {
			_soma.injector.mapTo(EmptyView, EmptyView);
			assertTrue(_soma.injector.hasMapping(EmptyView));
			_soma.injector.removeMapping(EmptyView);
			assertFalse(_soma.injector.hasMapping(EmptyView));
		}
		
		[Test]
		public function testChildRemoveMapping():void {
			var child:ISomaInjector = _soma.injector.createChildInjector();
			child.mapTo(EmptyView, EmptyView);
			assertTrue(child.hasMapping(EmptyView));
			child.removeMapping(EmptyView);
			assertFalse(child.hasMapping(EmptyView));
		}
		
		[Test]
		public function testApplicationDomain():void {
			var value:ApplicationDomain = new ApplicationDomain();
			_soma.injector.setApplicationDomain(value);
			assertEquals(value, _soma.injector.getApplicationDomain());
		}
		
		[Test]
		public function testInjectInto():void {
			// TODO
		}
		
		[Test]
		public function testMapToInstance():void {
			// TODO
		}
		
//		[Test]
//		public function testInjectorDispose():void {
//			_injector.mapTo(EmptyView, EmptyViewMediator);
//			trace(_injector.hasMapping(EmptyView))
//			_injector.dispose();
//			trace(_injector.hasMapping(EmptyView))
//			assertFalse(_injector.hasMapping(EmptyView));
//			// TODO check dispose
//		}
		
//		[Test]
//		public function testGetMappingName():void {
////			_injector.inj.map(EmptyView).named("injection name").to(EmptyViewMediator);
////			var map:IMapping = _injector.inj.getMapping(EmptyView, "injection name");
////			trace("£££", map.name, map.type)
//			
////			_injector.map(String).named("gna").to(String);
////			trace(0, _injector.getMapping(String, "gna").name)
//			
//			
////			_injector.mapTo(IMediator, EmptyViewMediator);
////			trace("###", _injector.getMappingName(IMediator, "injection name"))
////			assertEquals(_injector.getMappingName(EmptyView), "injection name")
//			// TODO: check get mapping name and type as it doesn't make sense because you always need the name
//		}
		
	}
}