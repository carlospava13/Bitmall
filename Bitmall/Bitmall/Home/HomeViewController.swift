//
//  HomeViewController.swift
//  Bitmall
//
//  Created by Carlos Pava on 1/05/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit
import BitmallData

final class HomeViewController: BaseViewController {

    weak var delegate: HomeViewControllerDelegate?

    //MARK: Views
    lazy var scrollView: UIScrollView = {
        var scrollView = UIScrollView(frame: .zero)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()

    private lazy var collectionView: UICollectionView = {
        let flowLayout = CollectionViewHorizontalCustom(display: .inline)
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        collectionView.backgroundColor = .white
        collectionView.indicatorStyle = .white
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
        //ownPresenter.getHomeModel()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showCollectionViewWithAnimation()
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
        collectionView.delegate = collectionAdapter
        collectionAdapter.data.addAndNotify(observer: self, completionHandler: { [weak self] in
            self?.collectionView.reloadData()
        })
        collectionAdapter.delegate = ownPresenter
    }

    @objc func touchStartButton(_ button: UIButton) {
        ownPresenter.getHomeModel()
    }

    private func showCollectionViewWithAnimation() {
        animateCollectionView(lastPositionX: 0,
            newPositionX: collectionView.frame.width)
    }

    private func hideCollectionViewWithAnimation() {
        animateCollectionView(lastPositionX: collectionView.frame.width,
            newPositionX: 0)
    }

    private func animateCollectionView(lastPositionX: CGFloat, newPositionX: CGFloat) {
        collectionView.layoutIfNeeded()
        collectionView.frame.origin.x += newPositionX
        UIView.animate(withDuration: 0.8) {
            self.collectionView.frame.origin.x = lastPositionX
        }
    }
}

extension HomeViewController: HomeView {
    
    func setHomeModels(_ models: [HomeModel]) {
        collectionAdapter?.data.value = models
    }
    
    func showError(_ error: Error) {
        print(error)
    }

    func updateItem(_ state: Bool, row: Int) {
        UIView.animate(withDuration: 0.5, animations: {
            self.collectionAdapter.data.value[row].selected = state
        }) { (finished) in
            self.hideCollectionViewWithAnimation()
        }
    }
}

