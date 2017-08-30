//
//  WeatherForcast.swift
//  BackBoneWeatheriOSApp
//
//  Created by KENNETH GRANDBERRY on 8/30/17.
//  Copyright © 2017 KENNETH GRANDBERRY. All rights reserved.
//

import Foundation

class WeatherForcast {
    
    //TODO: check data type when parsing JSON
    private var _temperature:String
    private var _humidity:String
    private var _rainPercentage:String
    private var _wind:String
    
    var temperature:String {
        return _temperature
    }
    
    var humidity:String {
        return _humidity
    }
    
    var rainPercentage:String {
        return _rainPercentage
    }
    
    var wind:String {
        return _wind
    }
    
    init(temp:String, humidity:String, rainPercentage:String, wind:String) {
        _temperature = temp
        _humidity = humidity
        _rainPercentage = rainPercentage
        _wind = wind
    }
}
