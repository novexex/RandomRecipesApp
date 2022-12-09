//
//  DrinkRouter.swift
//  testSfera
//
//  Created by Artour Ilyasov on 01.12.2022
//

protocol DrinkRouterProtocol {
    func buttonSavePressed(drink: ParcedDrinkClass)
}

class DrinkRouter: DrinkRouterProtocol {
    func buttonSavePressed(drink: ParcedDrinkClass) {
        favoritesVC?.getEntity(drink: drink)
    }
    
    
    weak var viewController: DrinkViewController?
    var favoritesVC: FavoritesViewProtocol?
    
    init(favoritesVC: FavoritesViewProtocol) {
        self.favoritesVC = favoritesVC
    }
}
