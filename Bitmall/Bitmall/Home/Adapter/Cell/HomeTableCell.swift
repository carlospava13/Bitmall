//
//  HomeTableCell.swift
//  Bitmall
//
//  Created by Carlos Pava on 2/05/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit
import BitmallData

final class HomeTableCell: BaseCollectionCell<HomeProductModel> {

    private lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setConstraints() {
        contentView.addSubview(titleLabel)
        let constraints = [
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        contentView.layoutSubviews()
    }

    override func setData(_ data: HomeProductModel) {
        titleLabel.text = data.title
    }
}
