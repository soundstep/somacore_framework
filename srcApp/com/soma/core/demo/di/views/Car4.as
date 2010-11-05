package com.soma.core.demo.di.views {
	/**
	 * @author Romuald Quantin
	 */
	public class Car4 {
		
	    protected var _engine:IEngine;
	    protected var _gps:GpsSystem;
	
	    public function Car4(engine:IEngine){
	      _engine = engine;
	    }
	
	    [Inject]
	    public function set gps(value:GpsSystem):void{
			_gps = value;
			trace(this, _gps.map.locale);
	    }
		
	}
}
