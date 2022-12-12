//
//  MealBuilder.swift
//  testSfera
//
//  Created by Artour Ilyasov on 01.12.2022
//

class MealBuilder {
    static func build(favoritesVC: FavoritesViewController) -> MealViewController {
        let interactor = MealInteractor()
        let router = MealRouter(favoritesVC: favoritesVC)
        let presenter = MealPresenter(interactor: interactor, router: router)
        let viewController = MealViewController()
        presenter.view  = viewController
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        
        return viewController
    }
}
