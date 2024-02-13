//
//  Double+Extension.swift
//  SeSac_Weather
//
//  Created by youngjoo on 2/12/24.
//

import Foundation

extension Double {
    var updateTemp: Double {
        return self - 273.15
    }
    
    /**
        온도를 String 으로 변환해주는 함수
     - Parameter format: string format. ex) "%.0f"
     */
    func formattedTemp(format: String) -> String {
        return String(format: format, self)
    }
    
    /**
        온도를 rounded 후, String 으로 변환해주는 함수
     - Parameter format: string format. ex) "%.0f"
     */
    func formattedRoundTemp(format: String) -> String {
        return String(format: format, self.rounded())
    }
}
