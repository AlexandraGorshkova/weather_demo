//
//  Weather.swift
//  Weather
//
//  Created by Alexandra Gorshkova on 24/01/2019.
//  Copyright © 2019 Alexandra Gorshkova. All rights reserved.
//

import Foundation
import SwiftyJSON

class WeatherClass {
    var date = 0 //: Data
    
    var startDate = 0
    var endDate = 0
    var temp = 0.0
    var weatherIcon = ""
    var cityName = ""
    
    init() {}
    
    init(json: JSON) {
        self.date = json["dt"].intValue
        self.temp = json["main"]["temp"].doubleValue
        self.weatherIcon = json["weather"][0]["icon"].stringValue
    }

}
