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
        self.roundCorners(corners: [.topLeft, .bottomLeft], radius: frame.height / 2 )
    }

    override func setupConstraints() {
        super.setupConstraints()
        guard let superview = superview else { return }
        let constraints = [
            heightAnchor.constraint(equalToConstant: 100),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 8)
        ]

        NSLayoutConstraint.activate(constraints)
        self.layoutIfNeeded()
    }

    func showCollectionViewWithAnimation() {
        animateCollectionView(lastPositionX: frame.width + 100,
            newPositionX: 0)
    }

    func hideCollectionViewWithAnimation() {
        animateCollectionView(lastPositionX: 0,
            newPositionX: frame.width + 100)
    }

    private func animateCollectionView(lastPositionX: CGFloat, newPositionX: CGFloat) {
        self.layoutIfNeeded()
        frame.origin.x = lastPositionX
        UIView.animate(withDuration: 0.8) {
            self.frame.origin.x = newPositionX
        }
    }
}

