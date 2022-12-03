//
//  DrinkBuilder.swift
//  testSfera
//
//  Created by Artour Ilyasov on 01.12.2022
//

import UIKit

class DrinkBuilder {
    static func build() -> DrinkViewController {
        let interactor = DrinkInteractor()
        let router = DrinkRouter()
        let presenter = DrinkPresenter(interactor: interactor, router: router)
        let viewController = DrinkViewController()
        presenter.view  = viewController
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
