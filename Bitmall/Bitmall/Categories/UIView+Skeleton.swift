//
//  UIView+Skeleton.swift
//  Bitmall
//
//  Created by Carlos Pava on 1/05/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit
import SkeletonView

extension UIView {
    func setSkeletonable(subviews: [UIView]) {
        self.isSkeletonable = true
        subviews.forEach({
            $0.isSkeletonable = true
            ($0 as? UILabel)?.linesCornerRadius = 5
        })
    }
}

extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}

