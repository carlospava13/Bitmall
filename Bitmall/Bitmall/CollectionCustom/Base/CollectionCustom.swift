//
//  CollectionCustom.swift
//  Bitmall
//
//  Created by Carlos Pava on 1/05/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit

class CollectionViewHorizontalCustom: UICollectionViewFlowLayout {
    
    var display : CollectionDisplay = .grid {
         didSet {
             if display != oldValue {
                 self.invalidateLayout()
             }
         }
     }
    
    var height: CGFloat? = 0 {
        didSet {
            self.configLayout()
        }
    }

     convenience init(display: CollectionDisplay) {
         self.init()
         self.display = display
         self.minimumLineSpacing = 10
         self.minimumInteritemSpacing = 10
     }

     func configLayout() {
         switch display {
         case .inline:
             self.scrollDirection = .horizontal
             if let height = self.height {
                 self.itemSize = CGSize(width: height, height: height)
             }

         case .grid:

             self.scrollDirection = .vertical
             if let collectionView = self.collectionView {
                 let optimisedWidth = (collectionView.frame.width - minimumInteritemSpacing) / 2
                 self.itemSize = CGSize(width: optimisedWidth , height: optimisedWidth) // keep as square
             }

         case .list:
             self.scrollDirection = .vertical
             if let collectionView = self.collectionView, let height = self.height {
                 self.itemSize = CGSize(width: collectionView.frame.width , height: height)
             }
         }
     }

     override func invalidateLayout() {
         super.invalidateLayout()
         self.configLayout()
     }
}
