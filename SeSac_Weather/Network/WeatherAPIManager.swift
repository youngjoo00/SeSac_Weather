//
//  WeatherAPIManager.swift
//  SeSac_Weather
//
//  Created by youngjoo on 2/11/24.
//

import Foundation

class WeatherAPIManager {
    
    static let shared = WeatherAPIManager()
    
    private init() { }
    
    func callRequest<T: Decodable>(type: T.Type,
                                   api: WeatherAPI,
                                   completionHandler: @escaping (T?, ErrorStatus?) -> Void) {
        
        var component = URLComponents(url: api.endpoint, resolvingAgainstBaseURL: false)
        
        component?.queryItems = api.parameter.map{ URLQueryItem(name: $0.key, value: $0.value)}
        
        guard let componentURL = component?.url else { return }
        let url = URLRequest(url: componentURL)
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            DispatchQueue.main.async {
                guard error == nil else {
                    completionHandler(nil, .failedRequest)
                    return
                }
                
                guard let data else {
                    print("데이터 에러: ", data ?? "데이터 없음")
                    completionHandler(nil, .noData)
                    return
                }
                
                guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                    print("응답코드 에러: ", response ?? "응답코드 없음")
                    completionHandler(nil, .invalidResponse)
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(type, from: data)
                    completionHandler(result, nil)
                } catch {
                    print("디코딩 실패", error)
                    completionHandler(nil, .invalidData)
                }
            }
        }.resume()
    }
}
