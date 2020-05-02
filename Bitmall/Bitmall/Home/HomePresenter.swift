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

    var worker: HomeSectionWorker!
    var workerProduct: HomeProductsWorker!
    
    var ownView: HomeView {
        return view as! HomeView
    }
    
    override init() {
        super.init()
        let firebase: FirebaseApiClient<HomeSectionApiModel> = FirebaseApiClient()
        worker = HomeSectionWorker(repository: HomeRepository(apiClient: firebase))
        workerProduct = HomeProductsWorker(repository: HomeProductRepository(apiClient: firebase))
    }

    func getHomeModel() {
        ownView.showSkeleton()
        worker.buildCase(params: nil) { (result) in
            switch result {
            case .success(let models):
                self.ownView.setHomeModels(models)
                guard let firtSection = models.first else {
                    return
                }
                self.selectedSection(type: firtSection.type.rawValue)
            case .failure(let error):
                self.ownView.showError(error)
            }
            self.ownView.hideSkeleton()
        }
    }
    
    func selectedSection(type: String) {
        workerProduct.buildCase(params: type) { (result) in
            switch result {
            case .success(let homeProducts):
                self.ownView.setHomeModelsToTable(homeProducts)
            case .failure(let error):
                self.ownView.showError(error)
            }
        }
    }
    
}

extension HomePresenter: HomeCollectionAdapterType {
    func selectedItem(_ item: HomeModel, row: Int) {
        selectedSection(type: item.type.rawValue)
    }
}
