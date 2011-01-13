package {
	import flash.display.Sprite;

	public class ViewInjected extends Sprite {
		
		[Inject]
		public function set simpleView(view:ISimpleView):void {
			trace("injected:", view);
		}
		
	}
}
