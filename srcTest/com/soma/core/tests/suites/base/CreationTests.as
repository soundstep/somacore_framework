package com.soma.core.tests.suites.base {	import org.flexunit.Assert;
		/**	 * <b>Author:</b> Romuald Quantin - <a href="http://www.soundstep.com/" target="_blank">www.soundstep.com</a><br />	 * <b>Class version:</b> 1.0<br />	 * <b>Actionscript version:</b> 3.0<br />	 * <b>Date:</b> Oct 6, 2010<br />	 * @example	 * <listing version="3.0"></listing>	 */		public class CreationTests {		//------------------------------------		// private, protected properties		//------------------------------------						//------------------------------------		// public properties		//------------------------------------								//------------------------------------		// constructor		//------------------------------------				public function CreationTests() {					}				//		// PRIVATE, PROTECTED		//________________________________________________________________________________________________								// PUBLIC		//________________________________________________________________________________________________				[Test]		public function testMe() : void {			Assert.assertTrue("Was not true", false);		}			}}