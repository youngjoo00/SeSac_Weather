//
//  String+Extension.swift
//  SeSac_Weather
//
//  Created by youngjoo on 2/12/24.
//

import Foundation

extension String {
    var updateIcon: String {
        return "https://openweathermap.org/img/wn/\(self)@2x.png"
    }
}
