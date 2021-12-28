//
//  CurrencyListScreenAssembly.swift
//  ExchangeRateApp
//
//  Created by Sveta on 22.12.2021.
//

import UIKit

final class CurrencyListScreenAssembly {
    static func buildViewController(persistenceManager: IValuteStorage, completion: @escaping (Valute) -> Void) -> UIViewController {
        let presenter = CurrencyListPresenter(persistenceManager: persistenceManager)
        presenter.onDidSelectValute = completion
        let viewController = CurrencyListViewController(presenter: presenter)
    
        return viewController
    }
}
