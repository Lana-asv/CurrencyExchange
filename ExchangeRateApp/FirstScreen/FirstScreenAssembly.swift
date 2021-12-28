//
//  FirstScreenAssembly.swift
//  ExchangeRateApp
//
//  Created by Sveta on 16.12.2021.
//

import UIKit

final class FirstScreenAssembly {
    static func buildViewController(persistenceManager: IValuteStorage) -> UIViewController {
        let presenter = FirstScreenPresenter(persistenceManager: persistenceManager)
        let viewController = AllCurrencyViewController(presenter: presenter)
        return viewController
    }
}
