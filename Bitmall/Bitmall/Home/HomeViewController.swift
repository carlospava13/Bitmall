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

    private lazy var sectionCollection: SectionCollection = {
        return SectionCollection(frame: .zero, layout: .inline)
    }()

    private lazy var tableView: CollectionView = {
        return CollectionView(frame: .zero, layout: .list)
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
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        view.layoutIfNeeded()
        arrangeViews()
    }

    private func arrangeViews() {
        stackView.addArrangedSubview(sectionCollection)
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
        tableViewHeightConstraint?.constant = tableView.collectionViewLayout.collectionViewContentSize.height
        UIView.animate(withDuration: 0.2) {
            self.view.layoutSubviews()
        }
    }

    @objc func touchStartButton(button: UIButton) {
        delegate?.nextPage()
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

