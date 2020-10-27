//
//  AnswerViewController.swift
//  GridNumberTrick
//
//  Created by Bogdan on 10/2/20.
//  Copyright © 2020 Bogdan Zarioiu. All rights reserved.
//

import UIKit


protocol AnswerViewControllerDelegate {
    func didTapResetButton()
    func passString(string: String)
}

class AnswerViewController: UIViewController {
     var answerLabel = UILabel()
     var answerLabelText = String()
    private var doneButton = UIButton()
    var delegate: AnswerViewControllerDelegate?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
        
        setupAnswerLabel()
        setupDoneButton()
 
}


    func setupAnswerLabel() {
        view.addSubview(answerLabel)
        answerLabel.text = answerLabelText
        answerLabel.translatesAutoresizingMaskIntoConstraints = false
        answerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        answerLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        answerLabel.textColor = .white
        answerLabel.backgroundColor = UIColor.systemGreen
        answerLabel.font = UIFont(name: "AvenirNext-Heavy", size: 200)
        
    }
    
    func setupDoneButton() {
        view.addSubview(doneButton)
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        doneButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        doneButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        doneButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        //styling the refresh button
        doneButton.setTitle("Done", for: .normal)
        doneButton.titleLabel?.font = UIFont(name: "AvenirNext-Heavy", size: 20)
        doneButton.backgroundColor = UIColor(named: "background")
        doneButton.tintColor = .white
        doneButton.layer.cornerRadius = 5
        doneButton.clipsToBounds = true
        
        doneButton.addTarget(self, action: #selector(handleDone(_:)), for: .touchUpInside)
        
    }

    
    @objc func handleDone(_ sender: UIButton) {
        answerLabel.text = ""
        dismiss(animated: true) {
            self.delegate?.didTapResetButton()
        }
        //delegate?.passString(string: "TEST")
        
        //my instance is being dealocated before calling the delegate method I think
        
    }

}
