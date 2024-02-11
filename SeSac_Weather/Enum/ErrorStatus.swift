//
//  ErrorStatus.swift
//  SeSac_Media
//
//  Created by youngjoo on 2/9/24.
//

import Foundation

enum ErrorStatus: String {
    case failedRequest = "네트워크 통신이 실패했어요"
    case noData = "통신은 성공했으나, 데이터를 받아오지 못했어요"
    case invalidResponse = "응답을 제대로 처리하지 못했어요"
    case invalidData = "서버에서 받은 데이터를 처리하는데 문제가 발생했어요"
}
