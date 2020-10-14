//
//  SecretInstructions.swift
//  GridNumberTrick
//
//  Created by Bogdan on 10/12/20.
//  Copyright © 2020 Bogdan Zarioiu. All rights reserved.
//

import Foundation
import UIKit



protocol SecretInstructionsDelegate {
    func handleDismissal()
    
}

class SecretInstructions: UIView {
    
    var delegate: SecretInstructionsDelegate?
    
    private var instructionsLabel: UILabel = {
        var instructions = UILabel()
        instructions.translatesAutoresizingMaskIntoConstraints = false
        instructions.textColor = .black
        instructions.font = UIFont(name: "AvenirNext-Heavy", size: 12)
        instructions.numberOfLines = 0
        instructions.text = "Ask the spectator to think of a number between 1 and 63.\nNow, ask him to tap on the card if his number is there.\nLet him scroll through the cells and tap the ones containing his number.\nA green square will appear around the selected cells.\n\nThe phone is doing all the work for you: it adds the top left number of each cell each time the spectator selects it.\nThese numbers are: 16, 4, 8, 2 32 1.\n\n\nThere is a RESET button that takes you to the initial grid of numbers ans resets everything so you can perform again.\n\nI hope you'll have fun using this little trick and thank you for trying it!🍻"
        
        return instructions
    }()
    
    private var dismissButton: UIButton = {
        var button = UIButton()
        button.setTitle("OK", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.titleLabel?.font = UIFont(name: "AvenirNext-Heavy", size: 12)
        button.layer.cornerRadius = 5
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(handleDismiss(_:)), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGreen
        
        addSubview(instructionsLabel)
        instructionsLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        instructionsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        instructionsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        
        addSubview(dismissButton)
        dismissButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
        dismissButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        dismissButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true

        dismissButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    @objc private func handleDismiss(_ sender: UIButton) {
        delegate?.handleDismissal()
        
    }
}
