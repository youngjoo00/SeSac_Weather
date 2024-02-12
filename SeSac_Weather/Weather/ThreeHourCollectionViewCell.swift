//
//  ThreeHourCollectionViewCell.swift
//  SeSac_Weather
//
//  Created by youngjoo on 2/12/24.
//

import UIKit
import SnapKit
import Then

final class ThreeHourCollectionViewCell: BaseCollectionViewCell {
    
    let timeLabel = WhiteTitleLabel()
    let weatherImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    let tempLabel = WhiteTitleLabel()
    
    override func configureHierarchy() {
        [
            timeLabel,
            weatherImageView,
            tempLabel
        ].forEach { contentView.addSubview($0) }
    }
    
    override func configureLayout() {
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.centerX.equalTo(contentView)
            make.height.equalTo(15)
        }
        
        weatherImageView.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom)
            make.center.equalTo(contentView)
            make.height.equalTo(80)
        }
        
        tempLabel.snp.makeConstraints { make in
            make.top.equalTo(weatherImageView.snp.bottom)
            make.centerX.equalTo(contentView)
            make.height.equalTo(20)
        }
    }
    
    override func configureView() {
    }
}
