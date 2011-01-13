package {
	import uk.co.ziazoo.injector.IInjector;
	import uk.co.ziazoo.injector.impl.Injector;

	import flash.display.Sprite;

	/**
	 * @author romuald
	 */
	public class Main extends Sprite {
		public function Main() {
			
			var injector:IInjector = Injector.createInjector();
			injector.map(ISimpleView).toInstance(new SimpleView());
			var child:IInjector = injector.createChildInjector();
			child.inject(ViewInjected);
			
//			var injector:ISomaInjector = new SomaInjector();
//			injector.mapToInstance(ISimpleView, new SimpleView(), "injectionName");
//			//var child:ISomaInjector = injector.createChildInjector();
//			injector.createInstance(ViewFromChildInjector);
			
		}
	}
}
