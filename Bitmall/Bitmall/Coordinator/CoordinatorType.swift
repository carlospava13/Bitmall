//
//  CoordinatorType.swift
//  Bitmall
//
//  Created by Carlos Pava on 1/05/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit

protocol CoordinatorType: AnyObject {
    //var childCoordinator: [CoordinatorType] { get set }
    
    init(navigationController: UINavigationController)
    
    func start()
}
