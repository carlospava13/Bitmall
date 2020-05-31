//
//  ApiClientType.swift
//  BitmallData
//
//  Created by Carlos Pava on 1/05/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Foundation

public protocol ApiClientType: AnyObject {
    associatedtype Model
    func request<Model:Codable>(child: String, completion: @escaping(Result<Model, Error>) -> Void)
}

open class BaseApiClient<T: Codable> : ApiClientType {
    public typealias Model = T
    
    public init() {}
    
    open func request<Model>(child: String, completion: @escaping (Result<Model, Error>) -> Void) where Model : Decodable, Model : Encodable {
        
    }
}
