//
//  HomePresenter.swift
//  Bitmall
//
//  Created by Carlos Pava on 1/05/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit
import BitmallData
import Firebase

final class HomePresenter: BasePresenter, HomePresenterType {

    var worker: HomeWorker!
    
    var ownView: HomeView {
        return view as! HomeView
    }
    
    override init() {
        super.init()
        let firebase: FirebaseApiClient<HomeApiModel> = FirebaseApiClient()
        worker = HomeWorker(repository: HomeRepository(apiClient: firebase))
    }

    func getHomeModel() {
        worker.buildCase { (result) in
            switch result {
            case .success(let models):
                self.ownView.setHomeModels(models)
            case .failure(let error):
                self.ownView.showError(error)
            }
        }
    }
    
    func getHome() {
        
    }
}

extension HomePresenter: HomeCollectionAdapterType {
    func selectedItem(_ item: HomeModel, row: Int) {
        ownView.updateItem(!item.selected, row: row)
    }
}
