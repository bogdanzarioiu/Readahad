//
//  NumbersCollectionViewCell.swift
//  GridNumberTrick
//
//  Created by Bogdan on 10/1/20.
//  Copyright © 2020 Bogdan Zarioiu. All rights reserved.
//

import UIKit

class NumbersCollectionViewCell: UICollectionViewCell {
    
    var grid: GridModel? {
        didSet {
            guard let grid = grid else { return }
            numbersGrid.image = UIImage(named: grid.gridName)
            selectedImage.image = UIImage(systemName: grid.selectionImage)
            
            
        }
    }
    private  let numbersGrid: UIImageView = {
        let n1Grid = UIImageView(image: UIImage(named: "Card1New"))
        n1Grid.contentMode = .scaleAspectFit
        n1Grid.translatesAutoresizingMaskIntoConstraints = false
        
        
        return n1Grid
    }()
    
     let selectedImage: UIImageView = {
         let image = UIImageView(image: (UIImage(systemName: "checkmark.circle")))
        image.tintColor = .systemGreen
        
         image.translatesAutoresizingMaskIntoConstraints = false
         
         return image
     }()
    

    
    override var isSelected: Bool {
          didSet {
            
            UIView.animate(withDuration: 0.15) {
                self.selectedImage.image = self.isSelected ? UIImage(systemName: "checkmark.circle.fill") : UIImage(systemName: "checkmark.circle")
                self.numbersGrid.transform = self.isSelected ? CGAffineTransform(scaleX: 1.05, y: 1.05) : CGAffineTransform.identity
            }
            
        
            
          }
      }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        

        //backgroundColor = UIColor(named: "background")
        //backgroundColor = .secondarySystemBackground
        backgroundColor = .clear
        setupNumbersGrid()
        
    }
    
    
    func setupNumbersGrid() {
        addSubview(selectedImage)
        selectedImage.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        selectedImage.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        selectedImage.heightAnchor.constraint(equalToConstant: 50).isActive = true
        selectedImage.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        
        
       
    
       
        //grid constraints
         addSubview(numbersGrid)
        numbersGrid.topAnchor.constraint(equalTo: selectedImage.bottomAnchor, constant: 16).isActive = true

        numbersGrid.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        numbersGrid.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
        numbersGrid.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        
        

        
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}
