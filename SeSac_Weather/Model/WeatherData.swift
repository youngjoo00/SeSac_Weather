//
//  Weather.swift
//  SeSac_Weather
//
//  Created by youngjoo on 2/11/24.
//

import Foundation

struct WeatherData: Decodable {
    let weather: [Weather]
    let main: Main
    let wind: Wind
    let clouds: Clouds
    let name: String
    
    struct Weather: Decodable {
        let id: Int
        let main: String
        let description: String
        let icon: String
    }
    
    struct Main: Decodable {
        let temp: Double
        let feels_like: Double
        let temp_min: Double
        let temp_max: Double
        let pressure: Int
        let humidity: Int
        let sea_level: Int?
        let grnd_level: Int?
        
        enum CodingKeys: CodingKey {
            case temp
            case feels_like
            case temp_min
            case temp_max
            case pressure
            case humidity
            case sea_level
            case grnd_level
        }
        
        init(from decoder: Decoder) throws {
            let container: KeyedDecodingContainer<WeatherData.Main.CodingKeys> = try decoder.container(keyedBy: WeatherData.Main.CodingKeys.self)
            self.temp = try container.decode(Double.self, forKey: WeatherData.Main.CodingKeys.temp) - 273.15
            self.feels_like = try container.decode(Double.self, forKey: WeatherData.Main.CodingKeys.feels_like) - 273.15
            self.temp_min = try container.decode(Double.self, forKey: WeatherData.Main.CodingKeys.temp_min) - 273.15
            self.temp_max = try container.decode(Double.self, forKey: WeatherData.Main.CodingKeys.temp_max) - 273.15
            self.pressure = try container.decode(Int.self, forKey: WeatherData.Main.CodingKeys.pressure)
            self.humidity = try container.decode(Int.self, forKey: WeatherData.Main.CodingKeys.humidity)
            self.sea_level = try container.decodeIfPresent(Int.self, forKey: WeatherData.Main.CodingKeys.sea_level)
            self.grnd_level = try container.decodeIfPresent(Int.self, forKey: WeatherData.Main.CodingKeys.grnd_level)
        }
    }
    
    struct Wind: Decodable {
        let speed: Double
        let deg: Int
        let gust: Double
    }
    
    struct Clouds: Decodable {
        let all: Int
    }
    
}


