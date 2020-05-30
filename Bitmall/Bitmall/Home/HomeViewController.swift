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

    var router: HomeViewControllerDelegate?

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
        stackView.spacing = 10
        return stackView
    }()

    private lazy var containerSectionCollection: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()

    private lazy var sectionCollection: SectionCollection = {
        return SectionCollection(frame: .zero, layout: .inline)
    }()

    private lazy var tableView: CollectionView = {
        let collectionView = CollectionView(frame: .zero, layout: .list)
        collectionView.setHeight(80)
        return collectionView
    }()

    //MARK: Adapter
    private var collectionAdapter: HomeCollectionAdapter!
    private var tableAdapter: HomeTableAdapter!

    //MARK: Constraints

    private var tableViewHeightConstraint: NSLayoutConstraint?

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
        setTableViewConstraints()
        setupTableView()
        ownPresenter.getHomeModel()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        sectionCollection.showCollectionViewWithAnimation()
    }

    private func setupNavigationTitle() {
        navigationController?.setupLargeTitle("Home")
    }

    private func setupNagivationItem() {
        let button: UIButton = UIButton()
        button.setImage(UIImage(named: "starIcon"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(touchStartButton(button:)), for: .touchUpInside)
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
        setCollectionConstraints()
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
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -8),
            stackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            //stackView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor)
            //stackView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        view.layoutIfNeeded()
        arrangeViews()
    }
    
    private func setCollectionConstraints() {
        containerSectionCollection.addSubview(sectionCollection)
        let constraints = [
            sectionCollection.topAnchor.constraint(equalTo: containerSectionCollection.topAnchor),
            sectionCollection.leadingAnchor.constraint(equalTo: containerSectionCollection.leadingAnchor),
            sectionCollection.trailingAnchor.constraint(equalTo: containerSectionCollection.trailingAnchor),
            sectionCollection.bottomAnchor.constraint(equalTo: containerSectionCollection.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func arrangeViews() {
        stackView.addArrangedSubview(containerSectionCollection)
        stackView.addArrangedSubview(tableView)
        view.layoutIfNeeded()
    }

    private func setupCollectionView() {
        let identifierCell = CollectionViewCellIdentifier.sectionCollectionCell
        sectionCollection.register(SectionCollectionCell.self, forCellWithReuseIdentifier: identifierCell.rawValue)
        collectionAdapter = HomeCollectionAdapter(identifierCell: .sectionCollectionCell)
        sectionCollection.setAdapter(collectionAdapter)
        collectionAdapter.data.addAndNotify(observer: self, completionHandler: { [weak self] in
            self?.sectionCollection.reloadData()
        })
        collectionAdapter.delegate = ownPresenter
    }

    private func setTableViewConstraints() {
        tableViewHeightConstraint = tableView.heightAnchor.constraint(equalToConstant: 0)
        tableViewHeightConstraint?.isActive = true
    }

    private func setupTableView() {
        let identifierCell = CollectionViewCellIdentifier.homeTableCell

        tableView.register(HomeTableCell.self, forCellWithReuseIdentifier: identifierCell.rawValue)
        tableAdapter = HomeTableAdapter(identifierCell: .homeTableCell)
        tableView.dataSource = tableAdapter
        tableView.delegate = tableAdapter
        tableAdapter.data.addAndNotify(observer: self, completionHandler: { [weak self] in
            self?.tableView.reloadData()
            self?.updateTable()
        })
        collectionAdapter.delegate = ownPresenter
    }

    private func updateTable() {
        tableViewHeightConstraint?.constant = tableView.collectionViewLayout.collectionViewContentSize.height + 8
        UIView.animate(withDuration: 1) {
            self.view.layoutSubviews()
        }
    }

    @objc func touchStartButton(button: UIButton) {
        router?.nextPage()
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
            self.sectionCollection.hideCollectionViewWithAnimation()
        }
    }

    func setHomeModelsToTable(_ models: [HomeProductModel]) {
        tableAdapter.data.value = models
    }

    func showSkeleton() {
        sectionCollection.superview?.showSkeleton()
    }

    func hideSkeleton() {
        sectionCollection.superview?.hideSkeleton()
    }
}

