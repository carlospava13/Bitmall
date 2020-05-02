//
//  SectionCollectionCell.swift
//  Bitmall
//
//  Created by Carlos Pava on 1/05/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit
import BitmallData

final class SectionCollectionCell: BaseCollectionCell<HomeModel> {

    lazy var imageView: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()


    lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        identifier = .sectionCollectionCell

        setConstraint()
        setImageConstraints()
        setBorder()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setConstraint() {
        contentView.addSubview(titleLabel)
        let constraints = [
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    func setImageConstraints() {
        contentView.addSubview(imageView)
        let constraints = [
            imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 50),
            imageView.widthAnchor.constraint(equalToConstant: 50)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    func setBorder() {
        imageView.layoutIfNeeded()
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 1
        imageView.layer.cornerRadius = imageView.frame.height / 2
    }

    override func setData(_ data: HomeModel) {
        titleLabel.text = data.title
       // imageView.image = data.
    }

    func changeBackground(_ data: HomeModel) {
        let color: UIColor = data.selected ? .red : .white
        imageView.backgroundColor = color
    }
}
