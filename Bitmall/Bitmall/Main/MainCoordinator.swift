//
//  MainCoordinator.swift
//  Bitmall
//
//  Created by Carlos Pava on 1/05/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit

class MainCoordinator: CoordinatorType {

    unowned let navigationController: UINavigationController

    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let homeVC = HomeViewController()
        homeVC.delegate = self
        navigationController.viewControllers = [homeVC]
    }
}

extension MainCoordinator: HomeViewControllerDelegate {
    func nextPage() {
        print("next page")
    }
}
