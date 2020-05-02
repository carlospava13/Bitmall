//
//  HomeRepository.swift
//  BitmallData
//
//  Created by Carlos Pava on 1/05/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Foundation

public class HomeRepository<T:Codable>: HomeRepositoryType {

    private var apiClient: BaseApiClient<T>

    public init(apiClient: BaseApiClient<T>) {
        self.apiClient = apiClient
    }

    public func getHomeModel(completion: @escaping (Result<[HomeSectionApiModel], Error>) -> Void) {
        apiClient.request(child: "Home/Carousel", completion: completion)
    }
}
