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
        $0.font = .boldSystemFont(ofSize: 30)
    }
    
    let tempLabel = WhiteTitleLabel().then {
        $0.font = .boldSystemFont(ofSize: 50)
    }
    let descriptionLabel = WhiteTitleLabel()
    let tempMaxMinLabel = WhiteTitleLabel()
    
    let tableView = UITableView().then {
        $0.backgroundColor = .clear
        $0.register(WeatherTableViewCell.self, forCellReuseIdentifier: WeatherTableViewCell.identifier)
        $0.register(FiveDayTableViewCell.self, forCellReuseIdentifier: FiveDayTableViewCell.identifier)
        $0.register(SectionHeaderUnderLineView.self, forHeaderFooterViewReuseIdentifier: SectionHeaderUnderLineView.identifier)
        $0.rowHeight = 150
    }
    
    override func configureHierarchy() {
        [
            titleLabel,
            tempLabel,
            descriptionLabel,
            tempMaxMinLabel,
            tableView,
        ].forEach { addSubview($0) }
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(16)
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(30)
        }
        
        tempLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(50)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(tempLabel.snp.bottom).offset(5)
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(20)
        }
        
        tempMaxMinLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(5)
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(20)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(tempMaxMinLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
    }
}
