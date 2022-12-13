//
//  DrinkBuilder.swift
//  testSfera
//
//  Created by Artour Ilyasov on 01.12.2022
//

class DrinkBuilder {
    static func build(favoritesVC: FavoritesViewController, dataProvider: DataProvider) -> DrinkViewController {
        let interactor = DrinkInteractor()
        let router = DrinkRouter(favoritesVC: favoritesVC)
        let presenter = DrinkPresenter(interactor: interactor, router: router, dataProvider: dataProvider)
        let viewController = DrinkViewController()
        presenter.view  = viewController
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        
        return viewController
    }
}
