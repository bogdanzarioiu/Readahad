//
//  OnboardingPageView.swift
//  GridNumberTrick
//
//  Created by Bogdan on 10/8/20.
//  Copyright © 2020 Bogdan Zarioiu. All rights reserved.
//

import Foundation
import UIKit

class OnboardingPageView: UIView {
    let containerView = UIStackView()
    let descriptionLabel = UILabel()
    

    
    var titleLabel: UILabel {
       let label = UILabel()
        label.textColor = .black
        
        return label
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(containerView)
        containerView.distribution = .fillEqually
        containerView.axis = .vertical
        containerView.addArrangedSubview(titleLabel)
        containerView.addArrangedSubview(descriptionLabel)
        
        setupOnboardingPageView()
    }
    
    
    func setupOnboardingPageView() {
        titleLabel.text = "HELLO"
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
