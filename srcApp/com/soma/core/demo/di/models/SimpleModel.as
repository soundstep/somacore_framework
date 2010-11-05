package com.soma.core.demo.di.models {
	import com.soma.core.interfaces.IModel;
	import com.soma.core.model.Model;

	/**
	 * @author romuald
	 */
	public class SimpleModel extends Model implements IModel {
		
		public static var count:int = 0;
		
		public function SimpleModel() {
			trace(count++, this);
		}
		
	}
}
