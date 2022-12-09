//
//  DrinkRouter.swift
//  testSfera
//
//  Created by Artour Ilyasov on 01.12.2022
//

protocol DrinkRouterProtocol {
    func buttonSavePressed(lastLoadedDrink: ParcedDrink)
}

class DrinkRouter: DrinkRouterProtocol {
    func buttonSavePressed(lastLoadedDrink: ParcedDrink) {
        favoritesVC?.getEntity(drink: lastLoadedDrink)
    }
    
    
    weak var viewController: DrinkViewController?
    var favoritesVC: FavoritesViewProtocol?
    
    init(favoritesVC: FavoritesViewProtocol) {
        self.favoritesVC = favoritesVC
    }
}
