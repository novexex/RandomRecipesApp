//
//  MealRouter.swift
//  testSfera
//
//  Created by Artour Ilyasov on 01.12.2022
//

protocol MealRouterProtocol {
    func buttonSavePressed(meal: ParcedMeal)
}

class MealRouter: MealRouterProtocol {
    weak var viewController: MealViewController?
    var favoritesVC: FavoritesViewProtocol?
    
    init(favoritesVC: FavoritesViewProtocol) {
        self.favoritesVC = favoritesVC
    }
    
    func buttonSavePressed(meal: ParcedMeal) {
        favoritesVC?.getEntity(meal: meal)
    }
}
