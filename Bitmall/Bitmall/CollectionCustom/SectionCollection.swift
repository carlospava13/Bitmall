//
//  SectionCollection.swift
//  Bitmall
//
//  Created by Carlos Pava on 2/05/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit

final class SectionCollection: CollectionView {

    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = UIColor(red: 1, green: 175 / 255, blue: 207 / 255, alpha: 1)
        clipsToBounds = true
        flowLayout.height = 100
        roundCorners(corners: [.topLeft, .bottomLeft], radius: frame.height / 2)
    }

    override func setupConstraints() {
        super.setupConstraints()
        heightAnchor.constraint(equalToConstant: 100).isActive = true
        self.layoutIfNeeded()
    }

    func showCollectionViewWithAnimation() {
        animateCollectionView(lastPositionX: frame.width + 100,
            newPositionX: 8)
    }

    func hideCollectionViewWithAnimation() {
        animateCollectionView(lastPositionX: 8,
            newPositionX: frame.width + 100)
    }

    private func animateCollectionView(lastPositionX: CGFloat, newPositionX: CGFloat) {
        self.layoutIfNeeded()
        frame.origin.x = lastPositionX

        UIView.animate(withDuration: 0.8,
            animations: {
                self.frame.origin.x = newPositionX
            })
    }
}

