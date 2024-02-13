//
//  FiveDayTableViewCell.swift
//  SeSac_Weather
//
//  Created by youngjoo on 2/14/24.
//

import UIKit

class FiveDayTableViewCell: BaseTableViewCell {
    
    let dayLabel = WhiteTitleLabel()
    let iconImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    let tempMinLabel = WhiteTitleLabel().then {
        $0.textColor = .systemGray5
    }
    
    let tempMaxLabel = WhiteTitleLabel()
    
    override func configureHierarchy() {
        [
            dayLabel,
            iconImageView,
            tempMinLabel,
            tempMaxLabel,
        ].forEach { contentView.addSubview($0) }
    }
    
    override func configureLayout() {
        dayLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.leading.equalTo(contentView).offset(16)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.trailing.equalTo(tempMinLabel.snp.leading).offset(-10)
        }
        
        tempMinLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.centerX.equalTo(contentView).offset(30)
        }
        
        tempMaxLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.trailing.equalTo(contentView).offset(-16)
        }
    }
    
    override func configureView() {
        
    }
}
