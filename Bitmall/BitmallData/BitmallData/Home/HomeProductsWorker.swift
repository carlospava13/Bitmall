//
//  HomeProductsWorker.swift
//  BitmallData
//
//  Created by Carlos Pava on 2/05/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Foundation

import Foundation

public class HomeProductsWorker: WorkerType {

    typealias Respository = HomeProductRepositoryType
    typealias Model = [HomeProductModel]
    typealias Params = String
    let repository: Respository

    required public init(repository: HomeProductRepositoryType) {
        self.repository = repository
    }
    
    public func buildCase(params: String, completion: @escaping (Result<[HomeProductModel], Error>) -> Void) {
        repository.getProducstAbout(type: params) { (result) in
            switch result {
            case .success(let models):
                let parseModels = self.parseHomeProductModel(apiModel: models)
                completion(.success(parseModels))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func parseHomeProductModel(apiModel: [HomeProductApiModel]) -> [HomeProductModel] {
        return apiModel.map({ return HomeProductModel(title: $0.title, imageUrl: $0.imageUrl) })
    }
}
