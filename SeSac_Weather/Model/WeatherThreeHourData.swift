//
//  WeatherThreeHourData.swift
//  SeSac_Weather
//
//  Created by youngjoo on 2/11/24.
//

import Foundation

struct WeatherforecastData: Decodable {
    let list: [WeatherItem]
    
    struct WeatherItem: Decodable {
        let dt_txt: String
        let main: Main
        let weather: [Weather]
        
        struct Main: Decodable {
            let temp: Double
        }
        
        struct Weather: Decodable {
            let icon: String
        }
        
       
    }
    
    
}
