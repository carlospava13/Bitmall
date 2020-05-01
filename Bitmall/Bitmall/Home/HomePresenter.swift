//
//  HomePresenter.swift
//  Bitmall
//
//  Created by Carlos Pava on 1/05/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit

class HomePresenter: BasePresenter {

    var ownView: HomeView {
        return view as! HomeView
    }

    func getModels() {
        let models = [
            HomeModel(title: "Home1", icon: UIImage(named: "starIcon")),
            HomeModel(title: "Home2", icon: UIImage(named: "starIcon")),
            HomeModel(title: "Home3", icon: UIImage(named: "starIcon"))
        ]

        ownView.setHomeModels(models)
    }
}
