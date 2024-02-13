//
//  Setting.swift
//  SeSac_Media
//
//  Created by youngjoo on 2/9/24.
//

import Foundation

enum Weather: String, CaseIterable {
    case threeHour = "3시간 간격의 일기예보"
    case fiveDay = "5일 간의 일기예보"
    case location = "위치"
    case other = "기타 정보"
    
    var cellCount: Int {
        switch self {
        case .threeHour:
            return 1
        case .fiveDay:
            return 5
        case .location:
            return 1
        case .other:
            return 1
        }
    }
}
