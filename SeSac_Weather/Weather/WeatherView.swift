//
//  WeatherView.swift
//  SeSac_Weather
//
//  Created by youngjoo on 2/11/24.
//

import UIKit
import SnapKit
import Then

final class WeatherView: BaseView {
    
    let titleLabel = WhiteTitleLabel().then {
        $0.font = .boldSystemFont(ofSize: 20)
    }
    
    let tempLabel = WhiteTitleLabel().then {
        $0.font = .boldSystemFont(ofSize: 30)
    }
    let descriptionLabel = WhiteTitleLabel()
    let tempMaxLabel = WhiteTitleLabel()
    let tempMinLabel = WhiteTitleLabel()
    
    override func configureHierarchy() {
        [
            titleLabel,
            tempLabel,
            descriptionLabel,
            tempMaxLabel,
            tempMinLabel
        ].forEach { addSubview($0) }
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(16)
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(20)
        }
        
        tempLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(30)
        }
    }
    
    override func configureView() {
        
    }
}
