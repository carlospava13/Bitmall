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

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.backgroundColor = .green
        stackView.tintColor = .green
        return stackView
    }()

    private lazy var collectionView: UICollectionView = {
        let flowLayout = CollectionViewHorizontalCustom(display: .inline)
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .blue
        collectionView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        return collectionView
    }()

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
        view.backgroundColor = .white
        view.addSubview(scrollView)
    }

    override func setConstraints() {
        setupScrollConstraints()
        setupStackViewConstraints()
    }

    private func setupScrollConstraints() {
        let margin = view.layoutMarginsGuide
        let constraints: [NSLayoutConstraint] = [
            scrollView.topAnchor.constraint(equalTo: margin.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: margin.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    private func setupStackViewConstraints() {
        scrollView.addSubview(stackView)
        let constraints: [NSLayoutConstraint] = [
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        view.layoutIfNeeded()
        arrangeViews()
    }

    private func arrangeViews() {
        stackView.addArrangedSubview(collectionView)
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
        ownPresenter.getHomeModel()
    }
}

extension HomeViewController: HomeView {
    func setHomeModels(_ models: [HomeModel]) {
        collectionAdapter?.data.value = models
    }
}

