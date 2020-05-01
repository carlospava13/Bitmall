//
//  BaseViewController.swift
//  Bitmall
//
//  Created by Carlos Pava on 1/05/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    weak var presenter: PresenterType?
    
    override func viewDidLoad() {
         super.viewDidLoad()
        setupViews()
        setConstraints()
     }
    
    func setupViews() { }
    
    func setConstraints() { }
}
