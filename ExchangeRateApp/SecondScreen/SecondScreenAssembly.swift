//
//  SecondScreenAssembly.swift
//  ExchangeRateApp
//
//  Created by Sveta on 16.12.2021.
//

import UIKit

final class SecondScreenAssembly {
    static func buildViewController(persistenceManager: IValuteStorage) -> UIViewController {
        let presenter = SecondScreenPresenter()
        let router = Router()
        let viewController = SecondViewController(presenter: presenter)
        presenter.onOpenCurrensyListController = { completion in
            let targetController = CurrencyListScreenAssembly.buildViewController(persistenceManager: persistenceManager, completion: completion)
            router.setTargetController(controller: targetController)
            router.next()
        }
        router.setRootController(controller: viewController)
        
        return viewController
    }
}
