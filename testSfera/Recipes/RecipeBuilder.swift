//
//  RecipeBuilder.swift
//  testSfera
//
//  Created by Artour Ilyasov on 28.11.2022.
//

import UIKit

class RecipeBuilder {
    static func build() -> TabBarController {
        let interactor = RecipeInteractor()
        let router = RecipeRouter()
        let presenter = RecipePresenter(router: router, interactor: interactor)
        let tabBarController = TabBarController()
        tabBarController.presenter = presenter
        presenter.view = tabBarController
        interactor.presenter = presenter
        router.viewController = tabBarController
        
        return tabBarController
    }
}
