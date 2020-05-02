//
//  HomeProductRepository.swift
//  BitmallData
//
//  Created by Carlos Pava on 2/05/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Foundation

public class HomeProductRepository<T:Codable>: HomeProductRepositoryType {

    private var apiClient: BaseApiClient<T>

    public init(apiClient: BaseApiClient<T>) {
        self.apiClient = apiClient
    }
    
    public func getProducstAbout(type: String, completion: @escaping (Result<[HomeProductApiModel], Error>) -> Void) {
        apiClient.request(child: "Home/table/" + type , completion: completion)
    }
}
