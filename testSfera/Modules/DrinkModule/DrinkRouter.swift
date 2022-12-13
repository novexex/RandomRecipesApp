//
//  DrinkRouter.swift
//  testSfera
//
//  Created by Artour Ilyasov on 01.12.2022
//

protocol DrinkRouterProtocol {
    func buttonSavePressed(drink: ParcedDrink)
}

class DrinkRouter {
    weak var viewController: DrinkViewController?
    var favoritesVC: FavoritesViewProtocol?

    init(favoritesVC: FavoritesViewProtocol) {
        self.favoritesVC = favoritesVC
    }
}

extension DrinkRouter: DrinkRouterProtocol {
    func buttonSavePressed(drink: ParcedDrink) {
        favoritesVC?.getEntity(drink: drink)
    }
}
