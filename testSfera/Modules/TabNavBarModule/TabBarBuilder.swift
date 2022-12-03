//
//  TabBarBuilder.swift
//  testSfera
//
//  Created by Artour Ilyasov on 28.11.2022.
//

import UIKit

class TabBarBuilder {
    static func build() -> TabBarViewController {
        let interactor = TabBarInteractor()
        let router = TabBarRouter()
        let presenter = TabBarPresenter(router: router, interactor: interactor)
        let tabBarController = TabBarViewController()
        presenter.view = tabBarController
        interactor.presenter = presenter
        router.viewController = tabBarController
        tabBarController.presenter = presenter
        
        return tabBarController
    }
}
