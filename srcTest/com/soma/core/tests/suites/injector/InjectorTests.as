package com.soma.core.tests.suites.injector {
	import com.soma.core.Soma;
	import com.soma.core.di.SomaInjector;
	import com.soma.core.interfaces.ISoma;
	import com.soma.core.interfaces.ISomaInjector;
	import com.soma.core.tests.suites.support.EmptyInjector;
	import com.soma.core.tests.suites.support.EmptyView;
	import com.soma.core.tests.suites.support.IEmptyView;
	import com.soma.core.tests.suites.support.InjectedClass;
	import com.soma.core.tests.suites.support.InjectedInterface;

	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertNotNull;
	import org.flexunit.asserts.assertNull;
	import org.flexunit.asserts.assertTrue;
	import org.hamcrest.assertThat;
	import org.hamcrest.object.instanceOf;

	import mx.core.FlexGlobals;

	import flash.display.Stage;
	import flash.system.ApplicationDomain;
	
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
			_soma.injector.map(EmptyView, EmptyView);
			var view:EmptyView = _soma.injector.getInstance(EmptyView) as EmptyView;
			assertNotNull(view);
			assertThat(view, instanceOf(EmptyView));
		}
		
		[Test]
		public function testChildGetInstanceSucessFromParentMapping():void {
			var child:ISomaInjector = _soma.injector.createChildInjector();
			_soma.injector.map(EmptyView, EmptyView);
			var view:EmptyView = child.getInstance(EmptyView) as EmptyView;
			assertNotNull(view);
			assertThat(view, instanceOf(EmptyView));
		}
		
		[Test]
		public function testChildGetInstanceSucessFromChildMapping():void {
			var child:ISomaInjector = _soma.injector.createChildInjector();
			child.map(EmptyView, EmptyView);
			var view:EmptyView = child.getInstance(EmptyView) as EmptyView;
			assertNotNull(view);
			assertThat(view, instanceOf(EmptyView));
		}
		
		[Test(expects="Error")]
		public function testGetInstanceSucessFromChildMapping():void {
			var child:ISomaInjector = _soma.injector.createChildInjector();
			child.map(EmptyView, EmptyView);
			var view:EmptyView = _soma.injector.getInstance(EmptyView) as EmptyView;
			assertThat(view, instanceOf(EmptyView));
		}
		
		[Test(expects="Error")]
		public function testGetInstanceNamedError():void {
			_soma.injector.map(EmptyView, EmptyView);
			var view:EmptyView = _soma.injector.getInstance(EmptyView, "injection name") as EmptyView;
			assertNotNull(view);
			assertThat(view, instanceOf(EmptyView));
		}
		
		[Test]
		public function testGetInstanceNamedSuccess():void {
			_soma.injector.map(EmptyView, EmptyView, "injection name");
			var view:EmptyView = _soma.injector.getInstance(EmptyView, "injection name") as EmptyView;
			assertNotNull(view);
			assertThat(view, instanceOf(EmptyView));
		}
		
		[Test]
		public function testChildGetInstanceNamedSuccess():void {
			var child:ISomaInjector = _soma.injector.createChildInjector();
			_soma.injector.map(EmptyView, EmptyView, "injection name");
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
			_soma.injector.map(EmptyView, EmptyView);
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
		public function testMapToInstance():void {
			var view:EmptyView = new EmptyView();
			_soma.injector.mapToInstance(EmptyView, view);
			assertNotNull(_soma.injector.getInstance(EmptyView));
			assertEquals(view, _soma.injector.getInstance(EmptyView));
		}
		
		[Test]
		public function testMapToInstanceNamed():void {
			var view:EmptyView = new EmptyView();
			_soma.injector.mapToInstance(EmptyView, view, "injection name");
			assertNotNull(_soma.injector.getInstance(EmptyView, "injection name"));
			assertEquals(view, _soma.injector.getInstance(EmptyView, "injection name"));
		}
		
		[Test]
		public function testMapInterface():void {
			_soma.injector.map(IEmptyView, EmptyView);
			assertThat(_soma.injector.getInstance(IEmptyView), instanceOf(EmptyView));
			assertThat(_soma.injector.getInstance(IEmptyView), instanceOf(IEmptyView));
		}
		
		[Test]
		public function testMapInterfaceNamed():void {
			_soma.injector.map(IEmptyView, EmptyView, "injection name");
			assertThat(_soma.injector.getInstance(IEmptyView, "injection name"), instanceOf(EmptyView));
			assertThat(_soma.injector.getInstance(IEmptyView, "injection name"), instanceOf(IEmptyView));
		}
		
		[Test]
		public function testMapSingletonInterface():void {
			var view:EmptyView = new EmptyView();
			_soma.injector.mapToInstance(IEmptyView, view);
			var view1:IEmptyView = _soma.injector.getInstance(IEmptyView) as IEmptyView;
			var view2:IEmptyView = _soma.injector.getInstance(IEmptyView) as IEmptyView;
			assertNotNull(view);
			assertNotNull(view1);
			assertNotNull(view2);
			assertEquals(view, view1);
			assertEquals(view, view2);
			assertEquals(view1, view2);
		}
		
		[Test]
		public function testMapSingletonInterfaceNamed():void {
			var view:EmptyView = new EmptyView();
			_soma.injector.mapToInstance(IEmptyView, view, "injection name");
			var view1:IEmptyView = _soma.injector.getInstance(IEmptyView, "injection name") as IEmptyView;
			var view2:IEmptyView = _soma.injector.getInstance(IEmptyView, "injection name") as IEmptyView;
			assertNotNull(view);
			assertNotNull(view1);
			assertNotNull(view2);
			assertEquals(view, view1);
			assertEquals(view, view2);
			assertEquals(view1, view2);
		}
		
		[Test]
		public function testMapSingletonOf():void {
			_soma.injector.mapSingletonOf(IEmptyView, EmptyView);
			var view1:InjectedInterface = _soma.injector.createInstance(InjectedInterface) as InjectedInterface;
			var view2:InjectedInterface = _soma.injector.createInstance(InjectedInterface) as InjectedInterface;
			assertNotNull(view1.injected);
			assertNotNull(view2.injected);
			assertThat(view1.injected, instanceOf(EmptyView));
			assertThat(view1.injected, instanceOf(IEmptyView));
			assertThat(view2.injected, instanceOf(EmptyView));
			assertThat(view2.injected, instanceOf(IEmptyView));
			assertEquals(view1.injected, view2.injected);
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
			_soma.injector.map(EmptyView, EmptyView);
			assertTrue(_soma.injector.hasMapping(EmptyView));
			_soma.injector.removeMapping(EmptyView);
			assertFalse(_soma.injector.hasMapping(EmptyView));
		}
		
		[Test]
		public function testChildRemoveMapping():void {
			var child:ISomaInjector = _soma.injector.createChildInjector();
			child.map(EmptyView, EmptyView);
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
			var view:InjectedClass = new InjectedClass(); 
			_soma.injector.map(EmptyView, EmptyView);
			_soma.injector.injectInto(view);
			assertNotNull(view.injected);
			assertThat(view.injected, instanceOf(EmptyView));
		}
		
		[Test]
		public function testInjectorDispose():void {
			assertNotNull(_soma.injector);
			_soma.dispose();
			assertNull(_soma.injector);
		}
		
	}
}