//
//  SceneDelegate.swift
//  ExchangeRateApp
//
//  Created by Sveta on 09.12.2021.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate, UISearchBarDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let scene = scene as? UIWindowScene {
            self.window = UIWindow(windowScene: scene)
            
            let firstVCPicture = UIImage(named: "rate")
            let secondVCPicture = UIImage(named: "exchange")
            
            let persistenceManager = PersistenceManager()
            let firstViewController = FirstScreenAssembly.buildViewController(persistenceManager: persistenceManager)
            let secondViewController = SecondScreenAssembly.buildViewController(persistenceManager: persistenceManager)
            
            let firstNavigation = UINavigationController(rootViewController: firstViewController)
            UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
            let secondNavigationController = UINavigationController(rootViewController: secondViewController)
            
            firstNavigation.tabBarItem = UITabBarItem(title: "Курс валют", image: firstVCPicture, tag: 0)
            secondNavigationController.tabBarItem = UITabBarItem(title: "Конвертер", image: secondVCPicture, tag: 1)
            
            let tabBarController = UITabBarController()
            tabBarController.viewControllers = [firstNavigation, secondNavigationController]
            tabBarController.tabBar.tintColor = .white
            tabBarController.tabBar.barTintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            
            self.window?.rootViewController = tabBarController
            self.window?.makeKeyAndVisible()

        }
    }
}

