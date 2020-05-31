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
import SkeletonView

final class SectionCollectionCell: BaseCollectionCell<HomeModel> {

    lazy var containerView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var containerImageView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()

    lazy var imageView: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.isSkeletonable = true
        return imageView
    }()


    lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        identifier = .sectionCollectionCell
        contentView.addSubview(containerView)
        setContainerViewConstraints()
        setContainerImageViewConstraints()
        setImageConstraints()
        setConstraint()
        setLayer()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setContainerViewConstraints() {
        let constraints = [
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        containerView.layoutIfNeeded()
    }

    private func setContainerImageViewConstraints () {
        containerView.addSubview(containerImageView)
        let constraints = [
            containerImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            containerImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            containerImageView.heightAnchor.constraint(equalToConstant: 50),
            containerImageView.widthAnchor.constraint(equalToConstant: 50)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    func setImageConstraints() {
        containerImageView.addSubview(imageView)
        let constraints = [
            imageView.topAnchor.constraint(equalTo: containerImageView.topAnchor, constant: 8),
            imageView.leadingAnchor.constraint(equalTo: containerImageView.leadingAnchor, constant: 8),
            imageView.trailingAnchor.constraint(equalTo: containerImageView.trailingAnchor, constant: -8),
            imageView.bottomAnchor.constraint(equalTo: containerImageView.bottomAnchor, constant: -8)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    func setConstraint() {
        containerView.addSubview(titleLabel)
        let constraints = [
            titleLabel.topAnchor.constraint(equalTo: containerImageView.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func setLayer() {
        containerImageView.layoutIfNeeded()
        containerImageView.layer.cornerRadius = containerImageView.frame.width / 2
    }

    override func setData(_ data: HomeModel) {
        titleLabel.text = data.title

        if let imageUrl = data.imageUrl, let url = URL(string: imageUrl) {
            imageView.showSkeleton()
            imageView.sd_setImage(with: url) { (_, _, _, _) in
                self.imageView.hideSkeleton()
            }
        }
    }

    func changeBackground(_ data: HomeModel) {
        containerImageView.transform = CGAffineTransform(scaleX: 0, y: 0)
        UIView.animate(withDuration: 0.5,
                       delay: 0.5,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0.5,
                       options: [],
                       animations: {
            self.containerImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
        }, completion: nil)
        let color: UIColor = .white
        containerImageView.backgroundColor = color.withAlphaComponent(data.selected ? 1 : 0.5)
//        containerImageView.alpha = data.selected ? 1 : 0.4
//        imageView.alpha = 1
    }
}
