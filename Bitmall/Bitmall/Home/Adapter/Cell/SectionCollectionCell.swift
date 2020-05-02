//
//  SectionCollectionCell.swift
//  Bitmall
//
//  Created by Carlos Pava on 1/05/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit
import BitmallData
import SDWebImage
final class SectionCollectionCell: BaseCollectionCell<HomeModel> {
    
    lazy var containerView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

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
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 11)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        identifier = .sectionCollectionCell
        contentView.addSubview(containerView)
        setContainerViewConstraints()
        setImageConstraints()
        setConstraint()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setContainerViewConstraints() {
        let constraints = [
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        containerView.layoutIfNeeded()
    }

    func setConstraint() {
        containerView.addSubview(titleLabel)
        let constraints = [
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    func setImageConstraints() {
        containerView.addSubview(imageView)
        let constraints = [
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            imageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 50),
            imageView.widthAnchor.constraint(equalToConstant: 50)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    override func setData(_ data: HomeModel) {
        titleLabel.text = data.title
        if let imageUrl = data.imageUrl, let url = URL(string: imageUrl) {
            imageView.sd_setImage(with: url, completed: nil)
        }
    }

    func changeBackground(_ data: HomeModel) {
        let color: UIColor = data.selected ? .red : .white
        imageView.backgroundColor = color
    }
}
