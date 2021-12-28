//
//  FirstViewController.swift
//  ExchangeRateApp
//
//  Created by Sveta on 10.12.2021.
//

import UIKit

final class AllCurrencyViewController: UIViewController {
    private let presenter: IFirstScreenPresenter
    private let searchController = UISearchController(searchResultsController: nil)
    private var currencyView: AllCurrencyView?
    
    init(presenter: FirstScreenPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Курс обмена валют"
        self.createAndSetupCurrencyView()
        self.searchBarSetup()
    }
    
    private func createAndSetupCurrencyView() {
        let currentView = AllCurrencyView()
        currentView.translatesAutoresizingMaskIntoConstraints = false
        self.currencyView = currentView

        self.view.addSubview(currentView)
        
        NSLayoutConstraint.activate([
            currentView.topAnchor.constraint(equalTo: view.topAnchor),
            currentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            currentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            currentView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        self.presenter.loadView(view: currentView)
    }
}

extension AllCurrencyViewController: UISearchBarDelegate, UISearchResultsUpdating {
    
    func searchBarSetup() {
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchBar.placeholder = "Поиск"
        self.searchController.searchBar.tintColor = .white
        self.searchController.searchBar.barStyle = .black

        self.navigationItem.searchController = searchController

        self.definesPresentationContext = true
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        filterContentForSearchText(searchText)
    }
    
   func filterContentForSearchText(_ searchText: String) {
        self.presenter.filterValute(searchText: searchText)
    }
}

