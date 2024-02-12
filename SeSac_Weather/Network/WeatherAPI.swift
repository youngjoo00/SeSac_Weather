//
//  WeatherAPI.swift
//  SeSac_Weather
//
//  Created by youngjoo on 2/11/24.
//

import Foundation

enum WeatherAPI {
    case WeatherData(lat: Double, lon: Double)
    case WeatherCityIDData(id: Int)
    case WeatherforecastData(id: Int)
    
    // 열거형 자체는 인스턴스를 가질 수 없지만, 열거형의 케이스는 인스턴스 처럼 사용할 수 있다.
    // 그렇기 때문에, baseURL 같은 고정된 프로퍼티를 사용할 때 문제점이 발생한다.
    
    /*
     1. 문제점
     baseURL이 인스턴스 연산 프로퍼티라면 각 case에서 호출될 때마다 계산이 이루어진다.
     이 덕분에 각 인스턴스에 따라 다른 값을 반환하도록 할 수 있지만,
     이 경우에는 baseURL이 모든 인스턴스에서 동일하므로 그럴 필요가 없다.
     
     2. 여기서 정리된 생각
     그럼 baseURL 을 꺼낼때마다 타입 저장 프로퍼티였다면 열거형타입에서 한번에 가져오면 되는 일인데
     인스턴스 연산 프로퍼티라면, 열거형 타입에 접근해서 case 인스턴스에 접근해서 baseURL 을 가져오게 된다.
     이 때 일을 한 번 더 하니까 비효율적이라는 문제가 생기게 된 것이다.
     
     3. 해결점
     baseURL을 static으로 선언하면, 이 값을 한 번만 계산하고 모든 인스턴스에서 재사용할 수 있다.
     이 경우에는 연산이 줄어들고, 성능이 약간 향상될 수 있다.
     
     하지만, 고정된 값을 갖고 있는 경우에만 이 방식을 사용하자.
     연산 프로퍼티의 값이 인스턴스의 상태에 따라 달라져야 한다면, 인스턴스 연산 프로퍼티로 선언하는 것이 좋겠다.
     */
    
    private static let baseURL = "https://api.openweathermap.org"
    private static let baseParameters: [String: String] = ["lang": "kr", "appid": APIKey.WeatherKey]
    
    var endpoint: URL {
        switch self {
        case .WeatherData:
            return URL(string: WeatherAPI.baseURL + "/data/2.5/weather")!
        case .WeatherCityIDData:
            return URL(string: WeatherAPI.baseURL + "/data/2.5/weather")!
        case .WeatherforecastData:
            return URL(string: WeatherAPI.baseURL + "/data/2.5/forecast")!
        }
    }
    
    var parameter: [String: String] {
        var params = WeatherAPI.baseParameters
        switch self {
        case .WeatherData(let lat, let lon):
            params["lat"] = "\(lat)"
            params["lon"] = "\(lon)"
            return params
        case .WeatherCityIDData(let id):
            params["id"] = "\(id)"
            return params
        case .WeatherforecastData(let id):
            params["id"] = "\(id)"
            return params
        }
    }
    
}
