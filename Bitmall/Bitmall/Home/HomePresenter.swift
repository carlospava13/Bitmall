//
//  HomePresenter.swift
//  Bitmall
//
//  Created by Carlos Pava on 1/05/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit

final class HomePresenter: BasePresenter, HomePresenterType {

    var ownView: HomeView {
        return view as! HomeView
    }

    func getHomeModel() {
        let models = [
            HomeModel(title: "Home1", icon: UIImage(named: "starIcon")),
            HomeModel(title: "Home2", icon: UIImage(named: "starIcon")),
            HomeModel(title: "Home3", icon: UIImage(named: "starIcon"))
        ]

        ownView.setHomeModels(models)
    }
}
