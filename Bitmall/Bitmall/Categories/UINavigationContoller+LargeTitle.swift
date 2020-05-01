//
//  UINavigationContoller+LargeTitle.swift
//  Bitmall
//
//  Created by Carlos Pava on 1/05/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit

extension UINavigationController {
    func setupLargeTitle(_ title: String) {
        self.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        self.navigationBar.topItem?.title = title
    }
}
