//
//  WeatherVC.swift
//  rainyShinyCloudy
//
//  Created by park kyung suk on 2017/05/06.
//  Copyright © 2017年 park kyung suk. All rights reserved.
//

import UIKit

class WeatherVC: UIViewController , UITableViewDelegate , UITableViewDataSource{

    @IBOutlet weak var dateLabal: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentWeatherLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var currentWeather : CurrentWeather!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        currentWeather = CurrentWeather()
        currentWeather.downloadWeatherDetail {
            
            // download完了時、呼ばれる Callback closure
            //Setup UI to load downloadData
            
            self.updateMainUI()
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
    }
    
    
}

