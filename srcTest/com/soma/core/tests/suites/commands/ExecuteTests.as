package com.soma.core.tests.suites.commands {
	import org.flexunit.asserts.assertEquals;
	import com.soma.core.tests.suites.support.TestParallelCommand;
	import org.flexunit.asserts.fail;
	import org.flexunit.asserts.assertFalse;
	import flash.display.Sprite;
	import org.flexunit.asserts.assertTrue;
	import com.soma.core.tests.suites.support.TestCommand;
	import com.soma.core.tests.suites.support.TestEvent;
	import com.soma.core.interfaces.ISoma;
	import com.soma.core.Soma;
	import flash.display.Stage;
	import mx.core.FlexGlobals;
	
		private var _soma:ISoma;
		private var _executed:Boolean;
		private static var _stage:Stage;
		private var _spriteTestAccess:Sprite;
		
			_soma.addEventListener(TestEvent.TEST, setUserAccessFromInstance);
			_spriteTestAccess.addEventListener(TestEvent.TEST, setUserAccessFromDisplayList);
			_spriteTestAccess = null;
			_spriteTestAccess.dispatchEvent(new TestEvent(TestEvent.TEST, this));
		}

		[Test]
			defaultCheck();
			else if (_userAccessFromInstanceCount > 1) fail("User had access to the command from the framework twice");
			else if (_executed && _userAccessFromDisplayList) fail("User had access to the command from the display list");
			var soma:ISoma = new Soma(_stage);
			soma.addCommand(TestEvent.TEST, TestCommand);