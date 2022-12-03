//
//  FavoritesBuilder.swift
//  testSfera
//
//  Created by Artour Ilyasov on 01.12.2022
//

import UIKit

class FavoritesBuilder {
    static func build() -> FavoritesViewController {
        let interactor = FavoritesInteractor()
        let router = FavoritesRouter()
        let presenter = FavoritesPresenter(interactor: interactor, router: router)
        let viewController = FavoritesViewController()
        presenter.view  = viewController
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
