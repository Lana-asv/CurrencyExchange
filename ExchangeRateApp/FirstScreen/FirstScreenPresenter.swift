//
//  FirstScreenPresenter.swift
//  ExchangeRateApp
//
//  Created by Sveta on 15.12.2021.
//

import Foundation

protocol IFirstScreenPresenter {
    func loadView(view: AllCurrencyView)
    func filterValute(searchText: String)
}

final class FirstScreenPresenter: IFirstScreenPresenter {
    private let model: FirstScreenModel
    private weak var firstView: AllCurrencyView?
    
    init(persistenceManager: IValuteStorage) {
        self.model = FirstScreenModel(persistenceManager: persistenceManager)
        self.model.delegate = self
    }
    
    func loadView(view: AllCurrencyView) {
        self.firstView = view
        self.firstView?.delegate = self
        self.model.getData()
    }
}

extension FirstScreenPresenter: AllCurrencyViewDelegate {

    func allCurrencyViewNumberOfItems(_ allCurrencyView: AllCurrencyView) -> Int {
        return self.model.itemsCount()
    }
    
    func allCurrencyView(_ allCurrencyView: AllCurrencyView, itemAtIndex index: Int) -> Valute? {
        return self.model.itemAtIndex(index)
    }
}

extension FirstScreenPresenter: IFirstScreenModelDelegate {
    func modelDidUpdateItems(_ model: FirstScreenModel) {
        self.firstView?.reloadData()
    }
}

extension FirstScreenPresenter {
    func filterValute(searchText: String) {
        self.model.searchFilter(searchText: searchText)
        self.firstView?.reloadData()
    }
}
