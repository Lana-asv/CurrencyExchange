//
//  CurrencyListPresenter.swift
//  ExchangeRateApp
//
//  Created by Sveta on 21.12.2021.
//

import Foundation


import Foundation

protocol ICurrencyListPresenter {
    func itemsCount() -> Int
    func itemAtIndex(_ index: Int) -> Valute?
    
    func loadView(controller: CurrencyListViewController)
    func changeRate(at index: Int)
    func filterValute(searchText: String)
}

final class CurrencyListPresenter{
    private let model: FirstScreenModel
    private weak var viewController: CurrencyListViewController?
    
    var onDidSelectValute: ((Valute) -> Void)?
    
    init(persistenceManager: IValuteStorage) {
        self.model = FirstScreenModel(persistenceManager: persistenceManager)
        self.model.delegate = self
    }
}

extension CurrencyListPresenter: IFirstScreenModelDelegate  {
    func modelDidUpdateItems(_ model: FirstScreenModel) {
        self.viewController?.reloadData()
    }
}

extension CurrencyListPresenter: ICurrencyListPresenter {
    func loadView(controller: CurrencyListViewController) {
        self.viewController = controller
    }

    func itemsCount() -> Int {
        return self.model.itemsCount()
    }
    
    func itemAtIndex(_ index: Int) -> Valute? {
        return self.model.itemAtIndex(index)
    }

    func changeRate(at index: Int) {
        guard let valute = self.model.itemAtIndex(index) else {
            return
        }

        self.viewController?.navigationController?.popViewController(animated: true)
        self.onDidSelectValute?(valute)
    }
    
    func filterValute(searchText: String) {
        self.model.searchFilter(searchText: searchText)
        self.viewController?.reloadData()
    }
}
