//
//  GenericDataSource.swift
//  Bitmall
//
//  Created by Carlos Pava on 1/05/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit

class GenericDataSource<Cell:BaseCollectionCell, T>: GenericDinamic<T>, UICollectionViewDataSource {
    
    private var identifierCell: String

    init(identifierCell: CollectionViewCellIdentifier = .defaultCell) {
        self.identifierCell = identifierCell.rawValue
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.value.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifierCell, for: indexPath) as! Cell
        cell.setData(data.value[indexPath.section])
        return cell
    }
}
