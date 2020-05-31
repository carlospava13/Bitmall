//
//  BasePresenter.swift
//  Bitmall
//
//  Created by Carlos Pava on 1/05/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Foundation

class BasePresenter: PresenterType {
    
    weak var view: ViewType?
    
    func bind(_ view: ViewType) {
        self.view = view
    }
    
    func unBind() {
        self.view = nil
    }
}
