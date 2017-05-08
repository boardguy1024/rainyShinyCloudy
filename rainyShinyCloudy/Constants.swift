//
//  Constants.swift
//  rainyShinyCloudy
//
//  Created by park kyung suk on 2017/05/07.
//  Copyright © 2017年 park kyung suk. All rights reserved.
//

import Foundation


let BASE_URL = "http://samples.openweathermap.org/data/2.5/weather?"
let LATITUDE = "lat="
let LONGITUDE = "&lon="
let APP_ID = "&appid="
let APP_KEY = "b1b15e88fa797225412429c1c50c122a1"

typealias DownloadComplite = () -> ()

let CURRENT_WEATHER_URL = BASE_URL + LATITUDE + LONGITUDE + APP_ID + APP_KEY
let FORECAST_URL = "http://samples.openweathermap.org/data/2.5/forecast/daily?lat=35&lon=139&cnt=10&appid=b1b15e88fa797225412429c1c50c122a1"

