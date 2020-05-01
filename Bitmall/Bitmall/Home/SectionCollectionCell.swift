//
//  SectionCollectionCell.swift
//  Bitmall
//
//  Created by Carlos Pava on 1/05/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit

final class SectionCollectionCell: BaseCollectionCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        identifier = .sectionCollectionCell
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
