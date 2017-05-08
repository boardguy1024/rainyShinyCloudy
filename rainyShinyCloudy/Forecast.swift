//
//  Forecast.swift
//  rainyShinyCloudy
//
//  Created by park kyung suk on 2017/05/08.
//  Copyright © 2017年 park kyung suk. All rights reserved.
//

import UIKit
import Alamofire

class Forecast {
   private var _date: String!
   private var _weatherType: String!
   private var _highTemp: String!
   private var _lowTemp: String!
    
    var date: String {
        if _date == nil { _date = "" }
        return _date
    }
    var weatherType: String {
        if _weatherType == nil { _weatherType = "" }
        return _weatherType
    }
    var highTemp: String {
        if _highTemp == nil { _highTemp = "" }
        return _highTemp
    }
    var lowTemp: String {
        if _lowTemp == nil { _lowTemp = "" }
        return _lowTemp
    }
    
    init(weatherDic: Dictionary<String,AnyObject>) {
        
        if let temp = weatherDic["temp"] as? Dictionary<String,AnyObject> {
            
            if let min = temp["min"] as? Double {
                let kelvinToFahrenheitPreDivision = (min * (9/5) - 459.67)
                let kelvinToFahrenheit = Double(round(10 * kelvinToFahrenheitPreDivision / 10))
                self._lowTemp = "\(kelvinToFahrenheit)"
            }
            
            if let max = temp["max"] as? Double {
                let kelvinToFahrenheitPreDivision = (max * (9/5) - 459.67)
                let kelvinToFahrenheit = Double(round(10 * kelvinToFahrenheitPreDivision / 10))
                self._highTemp = "\(kelvinToFahrenheit)"
            }
        }
        
        if let weather = weatherDic["weather"] as? [Dictionary<String,AnyObject>] {
            if let main = weather[0]["main"] as? String {
                _weatherType = main
            }
        }
        
        if let date = weatherDic["dt"] as? Double {
            let unixConvertedDate = Date(timeIntervalSince1970: date)
            self._date = unixConvertedDate.dayOfTheWeek()
        }
    }
}

extension Date {
    func dayOfTheWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .none
        return dateFormatter.string(from: self)
    }
}
