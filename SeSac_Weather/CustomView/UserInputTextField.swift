//
//  UserInputTextField.swift
//  SeSac_Media
//
//  Created by youngjoo on 2/8/24.
//

import UIKit

class UserInputTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
        addLeftPadding()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension UserInputTextField {
    
    func configureView() {
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 8
        textColor = .white
    }
    
    func setPlaceholder(placeholder: String, color: UIColor) {
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: color])
    }
}
