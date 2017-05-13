//
//  WeatherVC.swift
//  rainyShinyCloudy
//
//  Created by park kyung suk on 2017/05/06.
//  Copyright © 2017年 park kyung suk. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class WeatherVC: UIViewController , UITableViewDelegate , UITableViewDataSource , CLLocationManagerDelegate{

    @IBOutlet weak var dateLabal: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentWeatherLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!

    var currentWeather : CurrentWeather!
    var forecast : Forecast!
    var forecasts = [Forecast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate =  self
        //位置正確度をベストに設定
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //画面上に表示されている時だけ、位置情報の利用を許可するもので、バックグラウンド状態では許可されない。
        locationManager.requestWhenInUseAuthorization()
        //大幅に位置が変更した時のみ位置情報を取得する。
        locationManager.startMonitoringSignificantLocationChanges()
        
        tableView.delegate = self
        tableView.dataSource = self
        currentWeather = CurrentWeather()
     
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //現在位置座標を取得
        locationAuthStatus()
    }
    
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            // 取得した位置情報をcurrentLocationに格納
            currentLocation = locationManager.location
            //取得した現在座標をLocationの座標に格納
//            print(currentLocation.coordinate.latitude, Location.sharedInstance.longitude)
            currentWeather.downloadWeatherDetail {
                
                // download完了時、呼ばれる Callback closure
                //Setup UI to load downloadData
                
                self.downloadForecaseData {
                    
                    self.updateMainUI()
                }
            }

           // print(Location.sharedInstance.latitude, Location.sharedInstance.longituce)
                  } else {
            // まだ取得前の場合には使用時のみGPS許可をリクエストする。
            locationManager.requestWhenInUseAuthorization()
            //もう一度このメソッドを呼び出す。
            locationAuthStatus()
            
            

        }
    }
    
    
    func downloadForecaseData(comlited: @escaping DownloadComplete) {
        //Downloading forecast weatehr data for tableView
        let forecastURL = URL(string: FORECAST_URL)!
        
        Alamofire.request(forecastURL).responseJSON { (response) in
            
            let result = response.result
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let list = dict["list"] as? [Dictionary<String,AnyObject>] {
                    
                    for obj in list {
                        let forecast = Forecast(weatherDic: obj)
                        self.forecasts.append(forecast)
                        print(obj)
                    }
                    self.forecasts.remove(at: 0)
                    self.tableView.reloadData()
                }
            }
            comlited()
        }
    }
    
    func updateMainUI() {
        dateLabal.text = currentWeather.date
        currentTempLabel.text = currentWeather.currentTemp
        currentWeatherLabel.text = currentWeather.weatherType
        locationLabel.text = currentWeather.cityName
        currentWeatherImage.image = UIImage(named: currentWeather.weatherType)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! WeatherCell
        
        cell.configureCell(forecast: forecasts[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return forecasts.count
    }
    
    
    
    
    
    
    
    
    
    
    
    
}

