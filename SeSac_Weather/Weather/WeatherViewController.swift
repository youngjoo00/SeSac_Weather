//
//  WeatherViewController.swift
//  SeSac_Weather
//
//  Created by youngjoo on 2/11/24.
//

import UIKit

final class WeatherViewController: BaseViewController {
    
    let mainView = WeatherView()
    
    var weatherData: WeatherData?
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchWeather()
        
    }
}

extension WeatherViewController {
    
    func fetchWeather() {
        WeatherAPIManager.shared.callRequest(type: WeatherData.self, api: .WeatherCityIDData(id: 1846266)) { weather, error in
            if let weather {
                self.weatherData = weather
                guard let weatherData = self.weatherData else { return }
                self.mainView.titleLabel.text = weatherData.name
                self.mainView.tempLabel.text = "\(weatherData.main.temp)"
            } else {
                guard let error else { return }
                print(error)
                self.showToast(message: error.rawValue)
            }
        }
    }
}
