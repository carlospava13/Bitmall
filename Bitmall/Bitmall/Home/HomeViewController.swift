//
//  HomeViewController.swift
//  Bitmall
//
//  Created by Carlos Pava on 1/05/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit

final class HomeViewController: BaseViewController {

    var scrollView: UIScrollView = {
        var scrollView = UIScrollView(frame: .zero)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .white
        return scrollView
    }()
    
    var collectionView: UICollectionView = {
        var collectionView = UICollectionView()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isPagingEnabled = true
        collectionView.collectionViewLayout = CollectionViewHorizontalCustom()
        return collectionView
    }()
    
    var collectionAdapter: HomeCollectionAdapter?
    weak var delegate: HomeViewControllerDelegate?
    var ownPresenter: HomePresenterType {
        return presenter as! HomePresenterType
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationTitle()
        setupNagivationItem()
        setupCollectionView()
    }
    
    func setupNavigationTitle() {
        navigationController?.setupLargeTitle("Home")
    }

    func setupNagivationItem() {
        let button: UIButton = UIButton()
        button.setImage(UIImage(named: "starIcon"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(touchStartButton(_:)), for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    override func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(collectionView)
    }

    override func setConstraints() {
        let constraints: [NSLayoutConstraint] = [
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupCollectionView() {
        collectionAdapter = HomeCollectionAdapter(collectionView: collectionView, identifierCell: .sectionCollectionCell)
        collectionView.dataSource = collectionAdapter
    }

    @objc func touchStartButton(_ button: UIButton) {
        delegate?.nextPage()
    }
}

