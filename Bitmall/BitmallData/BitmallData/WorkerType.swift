//
//  WorkerType.swift
//  BitmallData
//
//  Created by Carlos Pava on 1/05/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Foundation

protocol WorkerType: AnyObject {
    associatedtype Respository
    associatedtype Model
    associatedtype Params
    init(repository:Respository)
    func buildCase(params: Params,completion: @escaping(_ result: Result<Model,Error>) -> Void)
}
