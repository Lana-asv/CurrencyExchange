//
//  SecondScreenPresenter.swift
//  ExchangeRateApp
//
//  Created by Sveta on 16.12.2021.
//

import Foundation

final class SecondScreenPresenter {
    private let model = SecondScreenModel()
    private weak var viewController: SecondViewController?
    
    var onOpenCurrensyListController: (( @escaping (Valute) -> Void ) -> (Void))?
    
}

extension SecondScreenPresenter {
    func viewDidLoad(viewController: SecondViewController) {
        self.viewController = viewController
    }
    
    func itemsCount() -> Int {
        self.model.itemsCount()
    }

    func updateValute(at index: Int) {
        let completion: (Valute) -> Void = { [weak self] valute in
            self?.updateValute(valute, at: index)
        }
        
        self.onOpenCurrensyListController?(completion)
        self.viewController?.reloadData()
    }
    
    private func updateValute(_ valute: Valute, at index: Int) {
        self.model.updateValute(valute, at: index)
        self.viewController?.reloadData()
    }
    
    func item(at index: Int) -> ConverterCellModel {
        return self.model.itemAtIndex(index)
    }
    
    func updateAmount(_ amount: Decimal) {
        self.model.updateAmount(amount)
        self.viewController?.updateVisibleItems()
    }
    
    func addNewValute() {
        let completion: (Valute) -> Void = { [weak self] valute in
            self?.selectNewValute(valute)
        }
        
        self.onOpenCurrensyListController?(completion)
        self.viewController?.reloadData()
    }
  
    func removeValute(at index: Int) {
        self.model.removeValute(index)
        self.viewController?.reloadData()
    }
    
    private func selectNewValute(_ valute: Valute) {
        self.model.addNewValute(valute)
        self.viewController?.reloadData()
    }
}
