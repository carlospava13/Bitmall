//
//  HomeModel.swift
//  BitmallData
//
//  Created by Carlos Pava on 1/05/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Foundation

public struct HomeModel {
    public let title: String
    public let imageUrl: String?
    public let type: HomeType
    public var selected: Bool = false
}

public enum HomeType: String, Codable {
    case food
    case technology
}
