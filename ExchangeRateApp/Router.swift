//
//  Router.swift
//  ExchangeRateApp
//
//  Created by Sveta on 22.12.2021.
//

import UIKit

protocol IRouter {
    func setRootController(controller: UIViewController)
    func setTargetController(controller: UIViewController)
    func next()
}

final class Router {
    private var controller: UIViewController?
    private var targertController: UIViewController?
}

extension Router: IRouter {
    func setRootController(controller: UIViewController) {
        self.controller = controller
    }

    func setTargetController(controller: UIViewController) {
        self.targertController = controller
    }

    func next() {
        guard let next = self.targertController else {
            return
        }
        self.controller?.navigationController?.pushViewController(next, animated: true)
    }
    
    func presentNext() {
        guard let next = self.targertController else {
            return
        }
        self.controller?.navigationController?.present(next, animated: true, completion: nil)
    }
}
