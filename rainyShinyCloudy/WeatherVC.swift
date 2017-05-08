//
//  WeatherVC.swift
//  rainyShinyCloudy
//
//  Created by park kyung suk on 2017/05/06.
//  Copyright © 2017年 park kyung suk. All rights reserved.
//

import UIKit
import Alamofire

class WeatherVC: UIViewController , UITableViewDelegate , UITableViewDataSource{

    @IBOutlet weak var dateLabal: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentWeatherLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var currentWeather : CurrentWeather!
    var forecast : Forecast!
    var forecasts = [Forecast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        currentWeather = CurrentWeather()
        currentWeather.downloadWeatherDetail {
            
            // download完了時、呼ばれる Callback closure
            //Setup UI to load downloadData
            
            self.downloadForecaseData {
                
                 self.updateMainUI()
            }
        }
    }
    
    func downloadForecaseData(comlited: @escaping DownloadComplite) {
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
                }
            }
            self.tableView.reloadData()
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

