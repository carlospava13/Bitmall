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
            HomeModel(title: "Home3", icon: UIImage(named: "starIcon")),
            HomeModel(title: "Home4", icon: UIImage(named: "starIcon")),
            HomeModel(title: "Home5", icon: UIImage(named: "starIcon")),
            HomeModel(title: "Home6", icon: UIImage(named: "starIcon")),
            HomeModel(title: "Home7", icon: UIImage(named: "starIcon")),
            HomeModel(title: "Home8", icon: UIImage(named: "starIcon")),
            HomeModel(title: "Home9", icon: UIImage(named: "starIcon")),
            HomeModel(title: "Home10", icon: UIImage(named: "starIcon")),
            HomeModel(title: "Home11", icon: UIImage(named: "starIcon")),
            HomeModel(title: "Home12", icon: UIImage(named: "starIcon")),
            HomeModel(title: "Home13", icon: UIImage(named: "starIcon")),
            HomeModel(title: "Home14", icon: UIImage(named: "starIcon")),
            HomeModel(title: "Home15", icon: UIImage(named: "starIcon")),
            HomeModel(title: "Home16", icon: UIImage(named: "starIcon")),
            HomeModel(title: "Home17", icon: UIImage(named: "starIcon")),
            HomeModel(title: "Home18", icon: UIImage(named: "starIcon")),
            HomeModel(title: "Home19", icon: UIImage(named: "starIcon")),
        ]

        ownView.setHomeModels(models)
    }
}

extension HomePresenter: HomeCollectionAdapterType {
    func selectedItem(_ item: HomeModel, row: Int) {
        ownView.updateItem(!item.selected, row: row)
    }
}
