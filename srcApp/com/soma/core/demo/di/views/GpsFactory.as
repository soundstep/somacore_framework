package com.soma.core.demo.di.views {
	/**
	 * @author Romuald Quantin
	 */
	public class GpsFactory {

	    [Inject]
	    [Named(index="1", name="country code")]
	    public var locale:String;
	
	    public function GpsFactory(){}
	
	    [Provider]
	    public function getNewGps():GpsSystem {
	    	trace("provider", locale);
	        var map:CountryMap = new CountryMap( locale );
	        var gps:GpsSystem = new GpsSystem( map );
	        return gps;
	    }
	}

}
