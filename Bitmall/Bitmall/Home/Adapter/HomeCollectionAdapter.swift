//
//  HomeCollectionAdapter.swift
//  Bitmall
//
//  Created by Carlos Pava on 1/05/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit
import BitmallData

protocol HomeCollectionAdapterType: AnyObject {
    func selectedItem(_ item: HomeModel, row: Int)
}

final class HomeCollectionAdapter: GenericDataSource<SectionCollectionCell, HomeModel> {

    weak var delegate: HomeCollectionAdapterType?
    var moved: Bool = true
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.selectedItem(data.value[indexPath.row], row: indexPath.row)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath) as! SectionCollectionCell
        cell.changeBackground(data.value[indexPath.row])
        return cell
    }
}

