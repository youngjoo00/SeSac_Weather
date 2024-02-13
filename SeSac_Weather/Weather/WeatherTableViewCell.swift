//
//  ThreeHourWeather.swift
//  SeSac_Weather
//
//  Created by youngjoo on 2/12/24.
//

import UIKit

final class WeatherTableViewCell: BaseTableViewCell {
    
    let horizontalCollectionView = HorizontalCollectionView(frame: .zero, collectionViewLayout: HorizontalCollectionView.configureCollectionViewLayout()).then {
        $0.register(ThreeHourCollectionViewCell.self, forCellWithReuseIdentifier: ThreeHourCollectionViewCell.identifier)
    }
    
    override func configureHierarchy() {
        [
            horizontalCollectionView,
        ].forEach { contentView.addSubview($0) }
    }
    
    override func configureLayout() {
        horizontalCollectionView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        
    }
    
    override func configureView() {
    }
}
