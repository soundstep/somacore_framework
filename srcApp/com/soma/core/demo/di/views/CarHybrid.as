package com.soma.core.demo.di.views {
	/**
	 * @author Romuald Quantin
	 */
	public class CarHybrid extends Car3 {
		
	    public function CarHybrid(engine:HybridEngine){
	      super(engine);
	    }
	
	    [Inject]
	    [Named(index="1", name="hybrid")]
	    override public function setInterior(interior:IInterior):void{
	      super.setInterior(interior);
	    }
	}
}
