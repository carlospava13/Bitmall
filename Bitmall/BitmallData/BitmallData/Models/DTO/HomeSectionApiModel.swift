//
//  HomeSectionApiModel.swift
//  BitmallData
//
//  Created by Carlos Pava on 2/05/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Foundation

public struct HomeSectionApiModel: Codable {
    var title: String
    var imageUrl: String
    var type: Type
}

public enum Type: String, Codable {
    case food
    case technology
}
