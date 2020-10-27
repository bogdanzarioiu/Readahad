//
//  WelcomeViewController.swift
//  GridNumberTrick
//
//  Created by Bogdan on 10/8/20.
//  Copyright © 2020 Bogdan Zarioiu. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    //private let container
    private let scrollview = UIScrollView()
    private let welcomeTextView = UITextView()
    private let pageControl = UIPageControl()
    private let goToTrickButton = UIButton()
    
    private var onboardingData: [OnboardingPageModel]?
    
    private var pageView = OnboardingPageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        scrollview.delegate = self
        //view.backgroundColor = UIColor(named: "background")
        view.backgroundColor = .tertiarySystemBackground
        onboardingData =
            [
                OnboardingPageModel(title: "\nHello👋!\nWelcome to READAHAD!\n\nThis is a simple number guessing trick.\nThe idea of this whole app is that your phone can read someone's mind(hence the name😀).\n\nTo demonstrate this, you ask your spectator to think of a number between 1 and 63.\n\n\nYou ask them after this to tap on each of the grids that contain their thought of number.\nAt the end they press on GUESS NUMBER and the phone will read their mind🤯 "),
                OnboardingPageModel(title: "\nHOW THIS WORKS?\n\nEach time the spectator says their number is on a grid, you simply need to add the number in the top left corner to the sum(but the phone does this already for you).\n\nIf you go through the grids you will see that the top left numbers are : 16, 4, 8, 2 32 1 - all powers of 2.\nSo you can construct any number up to 63 included with these powers of 2.\n\nYou can access this info again at any time from the trick screen by tapping in the top right corner.\nIf you look closely you can see a small gray dot. Just tap around it anywhere you need a refresher.")]
//                OnboardingPageModel(title: "\nREMINDER\n\nYou can access this info again at any time from the trick screen by tapping in the top right corner\nIf you look closely you can see a small gray dot.Just tap around it anywhere you need a refresher.")
                
        
        
        
        
        setupScrollView()
        setupPageControl()
        setupGoToTrickButton()

    }
    
    private func setupScrollView() {
        view.addSubview(scrollview)
        
        scrollview.translatesAutoresizingMaskIntoConstraints = false
        scrollview.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollview.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollview.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollview.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.75).isActive = true
        
        
        
        

        scrollview.isPagingEnabled = true
        scrollview.isScrollEnabled = true
        scrollview.contentSize = CGSize(width: view.frame.size.width * 2, height: 0) //height 0 disables vertical scrolling; I had 2
        scrollview.backgroundColor = .systemGreen
        


        for x in 0 ..< 2 { //i had 3
            let pageView = UITextView(frame: CGRect(x: CGFloat(x) * (view.frame.size.width), y: 0, width: view.frame.size.width, height: view.frame.size.height))
            //pageView.backgroundColor = .systemRed
            //scrollview.addSubview(pageView)
            pageView.contentInset = UIEdgeInsets(top: 30, left: 16, bottom: 0, right: 16)
            pageView.isEditable = false
            pageView.text = onboardingData?[x].title
            pageView.font = UIFont(name: "AvenirNext-Heavy", size: 15)
            pageView.textColor = .label
            pageView.isSelectable = false
            //pageView.textContainer.lineBreakMode = .byWordWrapping
//            pageView.sizeToFit()
//            pageView.translatesAutoresizingMaskIntoConstraints = false
//            pageView.topAnchor.constraint(equalTo: scrollview.topAnchor).isActive = true
//            pageView.leadingAnchor.constraint(equalTo: scrollview.leadingAnchor).isActive = true
//            pageView.bottomAnchor.constraint(equalTo: scrollview.bottomAnchor).isActive = true
//            pageView.trailingAnchor.constraint(equalTo: scrollview.trailingAnchor).isActive = true
        
        
            
            
            scrollview.addSubview(pageView)
            pageView.backgroundColor = .secondarySystemBackground
            //pageView.backgroundColor = .systemGreen
        }

        
    }
    
    
    
    
    private func setupGoToTrickButton() {
        view.addSubview(goToTrickButton)
        goToTrickButton.translatesAutoresizingMaskIntoConstraints = false
        goToTrickButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        goToTrickButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
        goToTrickButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        goToTrickButton.heightAnchor.constraint(equalToConstant: 60).isActive = true

        
        goToTrickButton.setTitle("Go to trick", for: .normal)
        goToTrickButton.titleLabel?.font = UIFont(name: "AvenirNext-Heavy", size: 20)
        goToTrickButton.backgroundColor = .systemGreen
        //goToTrickButton.tintColor = .white
        goToTrickButton.setTitleColor(.white, for: .normal)
        goToTrickButton.layer.cornerRadius = 5
        goToTrickButton.clipsToBounds = true
        
        
        
 
        
        

        goToTrickButton.addTarget(self, action: #selector(handleGoToTrick(_:)), for: .touchUpInside)
    }
    private func setupPageControl() {
        view.addSubview(pageControl)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
//        pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        pageControl.bottomAnchor.constraint(equalTo: goToTrickButton.topAnchor, constant: -20).isActive = true
        pageControl.topAnchor.constraint(equalTo: scrollview.bottomAnchor, constant: 20).isActive = true
        pageControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        pageControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        
        
        pageControl.numberOfPages = 2 //I had 2
        pageControl.currentPageIndicatorTintColor = .systemGreen
        pageControl.pageIndicatorTintColor = .systemGray
        //pageControl.backgroundColor = .systemGray
        pageControl.addTarget(self, action: #selector(pageControlDidChange(_:)), for: .valueChanged)
        
    }

    @objc private func pageControlDidChange(_ sender: UIPageControl) {
        let currentPage = sender.currentPage
        scrollview.setContentOffset(CGPoint(x: CGFloat(currentPage) * view.frame.size.width, y: 0), animated: true)
        
    }
    
    @objc private func handleGoToTrick(_ sender: UIButton) {
        let trickVC = ViewController()
        //trickVC.view.backgroundColor = .tertiarySystemBackground
        trickVC.modalPresentationStyle = .fullScreen
        present(trickVC, animated: true)
        
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "onboarding")
        
        
    }

}


extension WelcomeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
    }
}
