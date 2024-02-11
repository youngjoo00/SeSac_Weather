//
//  HorizontalCollectionViewCell.swift
//  SeSac_Media
//
//  Created by youngjoo on 1/30/24.
//

import UIKit
import SnapKit

class PosterCollectionViewCell: BaseCollectionViewCell {
    
    let posterImageView = PosterImageView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureHierarchy() {
        [
            posterImageView
        ].forEach { contentView.addSubview($0) }
    }
    
    override func configureLayout() {
        posterImageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        
    }
    
    override func configureView() {
        posterImageView.image = UIImage(systemName: "xmark")
    }
}
