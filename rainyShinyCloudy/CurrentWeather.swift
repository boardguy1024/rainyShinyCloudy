//
//  CurrentWeather.swift
//  rainyShinyCloudy
//
//  Created by park kyung suk on 2017/05/07.
//  Copyright © 2017年 park kyung suk. All rights reserved.
//

import UIKit
import Alamofire

class CurrentWeather {
   private var _cityName: String!
   private var _date: String!
   private var _weatherType: String!
   private var _currentTemp: Double!
    
    var cityName: String {
        if _cityName == nil { _cityName = "" }
        return _cityName
    }
    
    var date: String {
        if _date == nil { _date = "" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
        _date = "Today, \(currentDate)"
        return _date
    }
    var weatherType: String {
        if _weatherType == nil { _weatherType = "" }
        return _weatherType
    }
    var currentTemp: String {
        get {
            if _currentTemp == nil { _currentTemp = 0.0 }
            return String(_currentTemp) + "°"
        }
    }
    
    func downloadWeatherDetail(complited: @escaping DownloadComplite) {
        //Alamofire download
        let currentWeatherURL = URL(string: CURRENT_WEATHER_URL)!
        Alamofire.request(currentWeatherURL).responseJSON { (response) in
            
            let result = response
            print(result)
            
            if let dict = result.value as? Dictionary<String , AnyObject> {
                
                if let cityName = dict["name"] as? String {
                    self._cityName = cityName.capitalized
                }
                
                if let weather = dict["weather"] as? [Dictionary<String, AnyObject>] {
                    if let main = weather[0]["main"] as? String {
                        self._weatherType = main.capitalized
                    }
                }
                
                if let main = dict["main"] as? Dictionary<String, AnyObject> {
                    if let currentTemp = main["temp"] as? Double {
                        
                        let kelvinToFahrenheitPreDivision = (currentTemp * (9/5) - 459.67)
                        let kelvinToFahrenheit = Double(round(10 * kelvinToFahrenheitPreDivision / 10))
                        self._currentTemp = kelvinToFahrenheit
                    }
                }
            }
            //callback method
            complited()
        }
        
    }
    
    
    
    
    
    
    
    
    
}
