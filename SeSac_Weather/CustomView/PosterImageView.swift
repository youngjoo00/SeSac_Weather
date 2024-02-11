//
//  PosterImageView.swift
//  SeSac_Media
//
//  Created by youngjoo on 1/30/24.
//

import UIKit

class PosterImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 8
    }
}

extension PosterImageView {
    func configureView() {
        clipsToBounds = true
    }
}
