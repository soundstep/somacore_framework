package com.soundstep.somacolor.models {
	import com.soma.core.interfaces.IModel;
	import com.soma.core.model.Model;
	import com.soundstep.somacolor.controllers.events.ColorDataEvent;
	import com.soundstep.somacolor.vo.ColorVO;

	/**
	 * <b>Author:</b> Romuald Quantin - <a href="http://www.soundstep.com/" target="_blank">www.soundstep.com</a><br />* <b>Class version:</b> 1.0<br />
	 * <b>Actionscript version:</b> 3.0<br />
	 * <b>Copyright:</b> 
	 * <br />
	 * <b>Date:</b> Sep 18, 2009<br />
	 * <b>Usage:</b>
	 * @example
	 * <listing version="3.0"></listing>
	 */
	
	public class ColorModel extends Model implements IModel {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		

		//------------------------------------
		// public properties
		//------------------------------------
		
		public static const NAME:String = "Model::ColorModel";
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		public function ColorModel() {
			super(NAME);
		}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		override public function initialize():void {
			
		}
		
		override public function dispose():void {
			
		}
		
		private function getRandomColor():uint {
			return Math.random() * 0xFFFFFF;
		}
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		public function get colors():ColorVO {
			return data as ColorVO;
		}
		
		public function loadData():void {
			data = new ColorVO(getRandomColor(), getRandomColor(), getRandomColor());
			dispatchEvent(new ColorDataEvent(ColorDataEvent.UPDATED));
		}
		
	}
}