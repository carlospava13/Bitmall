//
//  HomeContract.swift
//  Bitmall
//
//  Created by Carlos Pava on 1/05/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Foundation
import BitmallData

protocol HomePresenterType: PresenterType, HomeCollectionAdapterType {
    func getHomeModel()
}

protocol HomeView: ViewType {
    func setHomeModels(_ models: [HomeModel])
    func updateItem(_ state: Bool, row: Int)
    func showError(_ error: Error)
}
