//
//  CollectionCustom.swift
//  Bitmall
//
//  Created by Carlos Pava on 1/05/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit

class CollectionViewHorizontalCustom: UICollectionViewFlowLayout {
    
    override init() {
        super.init()
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init()
        setup()
    }
    
    private func setup() {
        scrollDirection = .horizontal
    }
}
