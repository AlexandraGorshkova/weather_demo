//
//  Service.swift
//  Weather
//
//  Created by Alexandra Gorshkova on 23/01/2019.
//  Copyright © 2019 Alexandra Gorshkova. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Service {
   
    let baseUrl = "http://api.openweathermap.org"
    let apiKey = "92cabe9523da26194b02974bfcd50b7e"
    
    func loadWeather(city: String, completion: @escaping ([WeatherClass]) -> Void ){
        let path = "/data/2.5/forecast"
        let parameters: Parameters = [
            "q": city,
            "units": "metric",
            "appid": apiKey
        ]
        let url = baseUrl + path
        
        //Alamofire.request(url, method: .get, parameters: parameters).responseJSON //{ repsonse in print(repsonse.value)
       // }
        Alamofire.request(url, method: .get, parameters: parameters).responseData { repsons in
            guard let data = repsons.value else { return }
            let json = JSON(data)
            
            let weatherR = json["list"].flatMap { WeatherClass(json: $0.1) }
            
            //print(weather)
            completion(weatherR)
        }
    }
}
