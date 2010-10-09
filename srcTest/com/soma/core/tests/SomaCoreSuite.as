package com.soma.core.tests {	import com.soma.core.tests.suites.facade.FacadeSuite;
	import com.soma.core.tests.suites.views.ViewsSuite;
	import com.soma.core.tests.suites.models.ModelsSuite;
	import com.soma.core.tests.suites.wires.WiresSuite;
	import com.soma.core.tests.suites.commands.CommandsSuite;
		/**	 * <b>Author:</b> Romuald Quantin - <a href="http://www.soundstep.com/" target="_blank">www.soundstep.com</a><br />	 * <b>Class version:</b> 1.0<br />	 * <b>Actionscript version:</b> 3.0<br />	 * <b>Date:</b> Oct 6, 2010<br />	 * @example	 * <listing version="3.0"></listing>	 */		[Suite]	[RunWith("org.flexunit.runners.Suite")]	public class SomaCoreSuite {		public var facadeSuite:FacadeSuite;				public var commandsSuite:CommandsSuite;		public var wiresSuite:WiresSuite;		public var modelsSuite:ModelsSuite;		public var viewsSuite:ViewsSuite;			}}