//
//  ViewController.swift
//  GridNumberTrick
//
//  Created by Bogdan on 9/30/20.
//  Copyright © 2020 Bogdan Zarioiu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
  lazy var popUpInstructionsWindow: SecretInstructions = {
        let popUpWindow = SecretInstructions()
        popUpWindow.delegate = self
        popUpWindow.translatesAutoresizingMaskIntoConstraints = false
        popUpWindow.layer.cornerRadius = 5
        
        return popUpWindow
    }()
    
    private let visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .light)
        let view = UIVisualEffectView(effect: blurEffect)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let titleLabel: UILabel = {
        let title = UILabel()
        title.text = "READAHAD"
        title.font = UIFont(name: "AvenirNext-Heavy", size: 40)
        title.textColor = .label
        title.translatesAutoresizingMaskIntoConstraints = false
        
        return title
    }()
    
    
    private let subtitleLabel: UILabel = {
        let subtitle = UILabel()
        subtitle.text = "・select the cards containing your thought of number between 1 and 63・"
        subtitle.font = UIFont(name: "AvenirNext-Regular", size: 10)
        subtitle.textColor = .label
        subtitle.translatesAutoresizingMaskIntoConstraints = false
        
        return subtitle
        
    }()
    
    private let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.numberOfPages = 6
        pc.currentPageIndicatorTintColor = .systemGreen
        pc.pageIndicatorTintColor = .systemGray
        pc.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        pc.translatesAutoresizingMaskIntoConstraints = false
        
        return pc
    }()
    

    
    
    
    private var yourNumber: Int = 0
    private var colectionView: UICollectionView!
    private let cellId = "cellId"
    
    private let hiddenInstructionsButton = UIButton()

    
    

    let grids = [
        GridModel(gridName: "UpdatedCard1", selectionImage: "circle"),
        GridModel(gridName: "UpdatedCard2", selectionImage: "circle"),
        GridModel(gridName: "UpdatedCard3", selectionImage: "circle"),
        GridModel(gridName: "UpdatedCard4", selectionImage: "circle"),
        GridModel(gridName: "UpdatedCard5", selectionImage: "circle"),
        GridModel(gridName: "UpdatedCard6", selectionImage: "circle")
     ]

        
    private let makeGuessButton = UIButton()
    private let resetButton = UIButton()
    private let instructionsLabel = UILabel()
    private let instructionsText = "Ask the spectator to think of a number between 1 and 63.\nNow, ask him to tap on the cell if his number is there.\nKeep scrolling through the cells and select the ones containing his number."
    private let showInstructionsButton = UIButton()
    


    override var prefersStatusBarHidden: Bool {
        true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .tertiarySystemBackground
        
      
        
        setupTitleLabel()
        setupSubtitleLabel()
        setupResetButton()
        setupGuessButton()
        setupCollectionView()
        setupPageControl()
        setupHiddenInstructionsButton()
        setupVisualEffectView()

    
        colectionView.delegate = self
        colectionView.dataSource = self

        colectionView.register(NumbersCollectionViewCell.self, forCellWithReuseIdentifier: cellId)

        


}
    

    
    func setupVisualEffectView() {
        view.addSubview(visualEffectView)
              
        visualEffectView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        visualEffectView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        visualEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        visualEffectView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        visualEffectView.alpha = 0
        
    }
    
    
    func setupTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func setupSubtitleLabel() {
        view.addSubview(subtitleLabel)
        subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        subtitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
    }
    

    
    func setupHiddenInstructionsButton() {
        view.addSubview(hiddenInstructionsButton)
        
        hiddenInstructionsButton.translatesAutoresizingMaskIntoConstraints = false
        
        hiddenInstructionsButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        hiddenInstructionsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        hiddenInstructionsButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        hiddenInstructionsButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        hiddenInstructionsButton.setTitle("⊙", for: .normal)
        hiddenInstructionsButton.titleLabel?.font = UIFont(name: "AvenirNext-Regular", size: 7)
        hiddenInstructionsButton.setTitleColor(.gray, for: .normal)
        hiddenInstructionsButton.addTarget(self, action: #selector(handleSecretInstructions(_:)), for: .touchUpInside)

            }
    
    
 
    
    @objc private func handleSecretInstructions(_ sender: UIButton) {
        //print("Tapped!")
        view.addSubview(popUpInstructionsWindow)
        popUpInstructionsWindow.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        popUpInstructionsWindow.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        popUpInstructionsWindow.widthAnchor.constraint(equalToConstant: 300).isActive = true
        popUpInstructionsWindow.heightAnchor.constraint(equalToConstant: 500).isActive = true
        
        popUpInstructionsWindow.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        popUpInstructionsWindow.alpha = 0

        UIView.animate(withDuration: 0.3) {
            self.visualEffectView.alpha = 1
            self.popUpInstructionsWindow.alpha = 1
            self.popUpInstructionsWindow.transform = CGAffineTransform.identity
        }
      


    }
    
    

    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        
        colectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        
        view.addSubview(colectionView)
        
        colectionView.translatesAutoresizingMaskIntoConstraints = false

        colectionView.heightAnchor.constraint(equalToConstant: view.frame.size.height / 1.8).isActive = true
        colectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        colectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        colectionView.bottomAnchor.constraint(equalTo: makeGuessButton.topAnchor, constant: -80).isActive = true
        
        colectionView.backgroundColor = .tertiarySystemBackground
        colectionView.isPagingEnabled = true
        colectionView.allowsMultipleSelection = true
        colectionView.showsHorizontalScrollIndicator = false
        
        
    }
    
    private func setupPageControl() {
        view.addSubview(pageControl)
        pageControl.topAnchor.constraint(equalTo: colectionView.bottomAnchor, constant: -10).isActive = true
        pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    

    
    func setupGuessButton() {
        view.addSubview(makeGuessButton)
        makeGuessButton.translatesAutoresizingMaskIntoConstraints = false
        makeGuessButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        makeGuessButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        makeGuessButton.bottomAnchor.constraint(equalTo: resetButton.topAnchor, constant: -10).isActive = true
        makeGuessButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        makeGuessButton.setTitle("Guess the number", for: .normal)
        makeGuessButton.setTitleColor(.white, for: .normal)
        makeGuessButton.titleLabel?.font = UIFont(name: "AvenirNext-Heavy", size: 20)
// was background
        makeGuessButton.backgroundColor = .systemGreen
        makeGuessButton.alpha = 0.2
        makeGuessButton.isEnabled = false
        makeGuessButton.layer.cornerRadius = 5
        makeGuessButton.clipsToBounds = true
        
        makeGuessButton.addTarget(self, action: #selector(handleGuess(_:)), for: .touchUpInside)
    }
    
    @objc func handleGuess(_ sender: UIButton) {
        let answerVC =  AnswerViewController()
        answerVC.answerLabelText = "\(yourNumber)"
        answerVC.modalPresentationStyle = .fullScreen
    
        present(answerVC, animated: true)
       
    }
    
    func setupResetButton() {
        view.addSubview(resetButton)
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        resetButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        resetButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        resetButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        
        resetButton.setTitle("Reset", for: .normal)
        resetButton.setTitleColor(.white, for: .normal)
        resetButton.titleLabel?.font = UIFont(name: "AvenirNext-Heavy", size: 20)
        resetButton.backgroundColor = UIColor(named: "background")
        resetButton.alpha = 0.0
        resetButton.isEnabled = true
        resetButton.layer.cornerRadius = 5
        resetButton.clipsToBounds = true
        
        resetButton.addTarget(self, action: #selector(handleReset(_:)), for: .touchUpInside)
        
    }
    
    @objc func handleReset(_ sender: UIButton) {
        let firstIndexPath = IndexPath(item: 0, section: 0)
        colectionView.scrollToItem(at: firstIndexPath, at: .centeredHorizontally, animated: true)
        colectionView.reloadData()
        yourNumber = 0
        
        
        
    }
    


}


extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return grids.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! NumbersCollectionViewCell
        let grid = grids[indexPath.item]
        cell.grid = grid
            

        return cell
        
  
    }
    
    

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
  
            switch indexPath.item {
            case 0:
                yourNumber += 16
            case 1:
                yourNumber += 4
            case 2:
                yourNumber += 8
            case 3:
                yourNumber += 2
            case 4:
                yourNumber += 32
            case 5:
                yourNumber += 1
            default:
                yourNumber += 0
           
        }
  
    }
    

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        if (collectionView.cellForItem(at: indexPath) as? NumbersCollectionViewCell) != nil {
            
            switch indexPath.item {
                      case 0:
                          yourNumber -= 16
                      case 1:
                          yourNumber -= 4
                      case 2:
                          yourNumber -= 8
                      case 3:
                          yourNumber -= 2
                      case 4:
                          yourNumber -= 32
                      case 5:
                          yourNumber -= 1
                      default:
                          yourNumber -= 0
                      }
                   
               }
    }
    
    
    
}


extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let size = CGSize(width: view.frame.width, height: view.frame.height / 2)
        return size
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let width = scrollView.frame.size.width
        let page = scrollView.contentOffset.x / width
//        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(page)
    
        switch page {
        case 0.0:
            makeGuessButton.alpha = 0.2
            makeGuessButton.isEnabled = false
            resetButton.alpha = 0.0
            resetButton.isEnabled = false
        case 1.0:
            makeGuessButton.alpha = 0.2
            makeGuessButton.isEnabled = false
            resetButton.alpha = 0.0
            resetButton.isEnabled = false
        case 2.0:
            makeGuessButton.alpha = 0.2
            makeGuessButton.isEnabled = false
            resetButton.alpha = 0.0
            resetButton.isEnabled = false
        case 3.0:
            makeGuessButton.alpha = 0.2
            makeGuessButton.isEnabled = false
            resetButton.alpha = 0.0
            resetButton.isEnabled = false
        case 4.0:
            makeGuessButton.alpha = 0.2
            makeGuessButton.isEnabled = false
            resetButton.alpha = 0.0
            resetButton.isEnabled = false
        case 5.0:
            makeGuessButton.alpha = 1.0
            makeGuessButton.isEnabled = true
            resetButton.alpha = 1.0
            resetButton.isEnabled = true
        default:
            makeGuessButton.alpha = 0.2
            makeGuessButton.isEnabled = false
            resetButton.alpha = 0.0
            resetButton.isEnabled = false
        }
        
       
      
        
    }
    
   
  
}


extension ViewController: SecretInstructionsDelegate {
    func handleDismissal() {
        UIView.animate(withDuration: 0.3, animations: {
            self.visualEffectView.alpha = 0
            self.popUpInstructionsWindow.alpha = 0
            self.popUpInstructionsWindow.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }) { (_) in
            self.popUpInstructionsWindow.removeFromSuperview()
        }
    }
    
    
}




