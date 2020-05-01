//
//  HomeCoordinator.swift
//  Bitmall
//
//  Created by Carlos Pava on 1/05/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit

class HomeCoordinator: CoordinatorType {
    //var childCoordinator: [CoordinatorType]

    unowned let navigationController: UINavigationController

    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let homeVC = HomeViewController()
        homeVC.delegate = self
        homeVC.presenter = HomePresenter()
        self.navigationController.viewControllers = [homeVC]
    }
}

extension HomeCoordinator: HomeViewControllerDelegate {
    func nextPage() {
        print("next page")
    }
}
