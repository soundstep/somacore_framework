package com.soma.core.demo.di.views {
	
	public class Car3 {
	
	    private var _interior:IInterior;
	    private var _engine:IEngine;
	    
	    public function Car3(engine:IEngine){
	      _engine = engine;
	    }
	    
	    [Inject]
	    public function setInterior(interior:IInterior):void{
	      _interior = interior;
	      trace(this, ", interior set to:", interior);
	    }
	    
	    [PostConstruct]
	    public function startCar():void {
	        _engine.start();
	    }
	    
	}
}
