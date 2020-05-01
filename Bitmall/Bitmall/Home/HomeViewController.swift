//
//  HomeViewController.swift
//  Bitmall
//
//  Created by Carlos Pava on 1/05/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit

final class HomeViewController: BaseViewController {

    weak var delegate: HomeViewControllerDelegate?

    //MARK: Views
    lazy var scrollView: UIScrollView = {
        var scrollView = UIScrollView(frame: .zero)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .red
        return scrollView
    }()

    private lazy var collectionView: UICollectionView = {
        let flowLayout = CollectionViewHorizontalCustom(display: .inline)
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .red
        return collectionView
    }()
    
//    private lazy var viewCon: UIView = {
//        var view = UIView(frame: .zero)
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = .blue
//        return view
//    }()

    //MARK: Adapter
    private var collectionAdapter: HomeCollectionAdapter!

    //MARK: Presenter
    private var ownPresenter: HomePresenterType! {
        return presenter as? HomePresenterType
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        ownPresenter.bind(self)
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
        //view.addSubview(scrollView)
        view.addSubview(collectionView)
        //view.addSubview(viewCon)
    }

    override func setConstraints() {
        let constraints: [NSLayoutConstraint] = [
//            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
//            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            collectionView.topAnchor.constraint(equalTo: view.topAnchor,constant: 64),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 100)

        ]
        NSLayoutConstraint.activate(constraints)
        view.layoutIfNeeded()
    }

    private func setupCollectionView() {
        let identifierCell = CollectionViewCellIdentifier.sectionCollectionCell
        collectionView.register(SectionCollectionCell.self, forCellWithReuseIdentifier: identifierCell.rawValue)
        collectionAdapter = HomeCollectionAdapter(identifierCell: .sectionCollectionCell)
        collectionView.dataSource = collectionAdapter
        collectionAdapter.data.addAndNotify(observer: self, completionHandler: { [weak self] in
            self?.collectionView.reloadData()
        })
        
    }

    @objc func touchStartButton(_ button: UIButton) {
       // delegate?.nextPage()
        ownPresenter.getHomeModel()
    }
}

extension HomeViewController: HomeView {
    func setHomeModels(_ models: [HomeModel]) {
       // collectionAdapter.set(data: models)
        collectionAdapter?.data.value = models
    }
}

