//
//  HomeRepositoryType.swift
//  BitmallData
//
//  Created by Carlos Pava on 1/05/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Foundation

public protocol HomeRepositoryType: AnyObject {
    func getHomeModel(completion: @escaping(_ result:Result<[HomeSectionApiModel], Error>) -> Void)
}

public protocol HomeProductRepositoryType: AnyObject {
    func getProducstAbout(type: String, completion: @escaping(_ result:Result<[HomeProductApiModel], Error>) -> Void)
}
