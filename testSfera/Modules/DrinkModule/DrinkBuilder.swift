//
//  DrinkBuilder.swift
//  testSfera
//
//  Created by Artour Ilyasov on 01.12.2022
//

class DrinkBuilder {
    static func build(favoritesVC: FavoritesViewController) -> DrinkViewController {
        let interactor = DrinkInteractor()
        let router = DrinkRouter()
        let presenter = DrinkPresenter(interactor: interactor, router: router)
        let viewController = DrinkViewController()
        presenter.view  = viewController
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.presenter = presenter
        
        return viewController
    }
}
