//
//  WeatherThreeHourData.swift
//  SeSac_Weather
//
//  Created by youngjoo on 2/11/24.
//

import Foundation

struct WeatherForecastData: Decodable {
    var list: [WeatherItem]
    
    struct WeatherItem: Decodable {
        let dt_txt: String
        let main: Main
        let weather: [Weather]
        var day: String?
        var time: String?
        
        struct Main: Decodable {
            let temp: Double
            
            enum CodingKeys: CodingKey {
                case temp
            }
            
            init(from decoder: Decoder) throws {
                let container: KeyedDecodingContainer<WeatherForecastData.WeatherItem.Main.CodingKeys> = try decoder.container(keyedBy: WeatherForecastData.WeatherItem.Main.CodingKeys.self)
                self.temp = try container.decode(Double.self, forKey: WeatherForecastData.WeatherItem.Main.CodingKeys.temp).updateTemp
            }
        }
        
        struct Weather: Decodable {
            let icon: String
            
            enum CodingKeys: CodingKey {
                case icon
            }
            
            init(from decoder: Decoder) throws {
                let container: KeyedDecodingContainer<WeatherForecastData.WeatherItem.Weather.CodingKeys> = try decoder.container(keyedBy: WeatherForecastData.WeatherItem.Weather.CodingKeys.self)
                self.icon = try container.decode(String.self, forKey: WeatherForecastData.WeatherItem.Weather.CodingKeys.icon).updateIcon
            }
        }
        
       
    }
    
    
}
