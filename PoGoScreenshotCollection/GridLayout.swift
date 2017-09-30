//
//  GridLayout.swift
//  PoGoErrorCollection
//
//  Created by Marco Knipfer on 26.09.17.
//  Copyright © 2017 Marco Knipfer. All rights reserved.
//

import UIKit

class GridLayout: UICollectionViewFlowLayout {
    
    var numberOfColums: Int = 2
    let aspectRatio = CGFloat(16.0 / 9.0)
    
    init(numberOfColums: Int) {
        super.init()
        self.numberOfColums = numberOfColums
        self.minimumInteritemSpacing = 1
        self.minimumLineSpacing = 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var itemSize: CGSize {
        get {
            if let collectionView = self.collectionView{
                let collectionViewWidth = collectionView.frame.width
                let itemWidth = collectionViewWidth / CGFloat(numberOfColums) - self.minimumInteritemSpacing
                let itemHeight = CGFloat(itemWidth * aspectRatio)
                
                return CGSize(width: itemWidth, height: itemHeight)
            } else {
                return CGSize(width: 100, height: 100)
            }
        }
        
        set {
            super.itemSize = newValue
        }
    }
}

