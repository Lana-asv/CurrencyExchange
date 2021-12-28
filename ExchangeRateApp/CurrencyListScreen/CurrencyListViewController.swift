//
//  CurrencyListViewController.swift
//  ExchangeRateApp
//
//  Created by Sveta on 21.12.2021.
//

import UIKit

final class CurrencyListViewController: UIViewController, UISearchControllerDelegate {
    
    private let presenter: ICurrencyListPresenter
    private let searchController = UISearchController(searchResultsController: nil)
    
    init(presenter: ICurrencyListPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = ListCVFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout.createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.delaysContentTouches = false
        collectionView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CurrencyListViewCell.self, forCellWithReuseIdentifier: CurrencyListViewCell.identifier)
        return collectionView
    }()
    
    override func loadView() {
        self.view = self.collectionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Список валют"
        self.presenter.loadView(controller: self)
        self.searchBarSetup()

    }
}

extension CurrencyListViewController {
    func reloadData() {
        self.collectionView.reloadData()
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .plain)
        return UICollectionViewCompositionalLayout.list(using: config)
    }
}


extension CurrencyListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.presenter.itemsCount()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: CurrencyListViewCell.identifier, for: indexPath) as! CurrencyListViewCell
        let item = self.presenter.itemAtIndex(indexPath.item)
        cell.updated(item)
        return cell 
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        self.presenter.changeRate(at: indexPath.row)
    }
    
}

extension CurrencyListViewController: UISearchBarDelegate, UISearchResultsUpdating {
    private func searchBarSetup() {
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchBar.placeholder = "Поиск"
        self.searchController.searchBar.barStyle = .black

        self.navigationItem.searchController = searchController
        self.definesPresentationContext = true
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
  
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        filterContentForSearchText(searchText)
    }
    
   private func filterContentForSearchText(_ searchText: String) {
    self.presenter.filterValute(searchText: searchText)
    }
}
