//
//  FirebaseApiClient.swift
//  BitmallData
//
//  Created by Carlos Pava on 1/05/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Foundation
import Firebase
import BitmallData

class FirebaseApiClient<T: Codable>: BaseApiClient<T> {
    typealias Model = T

    override init() {
        super.init()
    }

    override func request<Model>(child: String, completion: @escaping (Result<Model, Error>) -> Void) where Model: Decodable, Model: Encodable {
        let reference = Database.database().reference(withPath: child)

        reference.observeSingleEvent(of: .value, with: { (dataSnapshot) in

            guard let value = dataSnapshot.value else { return }
            print("\n RESPONSE: \(value)\n")
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: value, options: [])
                let data = try JSONDecoder().decode(Model.self, from: jsonData)
                completion(.success(data))
            } catch let error {
                completion(.failure(error))
            }

        }) { (error) in
            completion(.failure(error))
        }
    }

}
