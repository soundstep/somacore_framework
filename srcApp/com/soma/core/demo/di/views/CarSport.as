package com.soma.core.demo.di.views {
	/**
	 * @author Romuald Quantin
	 */
	public class CarSport extends Car3 {
		
	    public function CarSport(engine:SportyEngine){
	      super(engine);
	    }
	
	    [Inject]
	    [Named(index="1", name="sport")]
	    override public function setInterior(interior:IInterior):void{
	      super.setInterior(interior);
	    }
	}
}
