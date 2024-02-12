//
//  SectionHeaderUnderLineView.swift
//  SeSac_Weather
//
//  Created by youngjoo on 2/12/24.
//

import UIKit

class SectionHeaderUnderLineView: UITableViewHeaderFooterView {
    
    let lineView = UIView().then {
        $0.backgroundColor = .systemGray5
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureHierarchy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureHierarchy() {
        addSubview(lineView)
    }
    
    private func configureLayout() {
        lineView.snp.makeConstraints { make in
            make.bottom.trailing.equalToSuperview()
            make.leading.equalToSuperview().inset(16)
            make.height.equalTo(1)
        }
    }
    
}
