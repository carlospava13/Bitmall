//
//  HomeWorker.swift
//  BitmallData
//
//  Created by Carlos Pava on 1/05/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Foundation

public class HomeSectionWorker: WorkerType {
    typealias Params = Any?
    typealias Respository = HomeRepositoryType
    typealias Model = [HomeModel]
    let repository: Respository

    required public init(repository: HomeRepositoryType) {
        self.repository = repository
    }

    public func buildCase(params: Any?, completion: @escaping (Result<[HomeModel], Error>) -> Void) {
        repository.getHomeModel { (result) in
            switch result {
            case .success(let models):
                let homeModel = self.parseHomeModel(apiModel: models)
                completion(.success(homeModel))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func parseHomeModel(apiModel: [HomeSectionApiModel]) -> [HomeModel] {
        return apiModel.map({ return HomeModel(title: $0.title, imageUrl: $0.imageUrl, type: HomeType(rawValue: $0.type.rawValue)!) })
    }
}
