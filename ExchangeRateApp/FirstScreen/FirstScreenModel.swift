//
//  FirstScreenModel.swift
//  ExchangeRateApp
//
//  Created by Sveta on 15.12.2021.
//

import Foundation

protocol IFirstScreenModel {
    func getData()
    func itemsCount() -> Int
    func itemAtIndex(_ index: Int) -> Valute?
    func searchFilter(searchText: String)
}

protocol IFirstScreenModelDelegate: AnyObject {
    func modelDidUpdateItems(_ model: FirstScreenModel)
}

final class FirstScreenModel: IFirstScreenModel {
    
    private var searchText: String?
    private let network = NetworkCBRManager()
    private let persistenceManager: IValuteStorage
    
    weak var delegate: IFirstScreenModelDelegate?
    
    init(persistenceManager: IValuteStorage) {
        self.persistenceManager = persistenceManager
    }
    
    func getData() {
        if self.itemsCount() > 0 {
            return
        }
        
        network.fetchRate { [weak self] items in
            guard let sself = self else {
                return
            }
            
            sself.persistenceManager.updateValutes(items)
            sself.delegate?.modelDidUpdateItems(sself)
        }
    }
    
    func itemsCount() -> Int {
        self.persistenceManager.getValutesCount(filter: self.searchText)
    }
    
    func itemAtIndex(_ index: Int) -> Valute? {
        return self.persistenceManager.getValute(at: index, filter: self.searchText)
    }
    
    func searchFilter(searchText: String) {
        self.searchText = searchText
    }
}
