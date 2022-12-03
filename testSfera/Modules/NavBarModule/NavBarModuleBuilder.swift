//
//  NavBarModuleBuilder.swift
//  Super easy dev
//
//  Created by Artour Ilyasov on 01.12.2022
//

import UIKit

class NavBarModuleBuilder {
    static func build(mealVC: MealViewController,
                      drinkVC: DrinkViewController,
                      favoritesVC: FavoritesViewController) -> [NavBarViewController] {
        let interactor = NavBarInteractor()
        let router = NavBarRouter()
        let presenter = NavBarPresenter(interactor: interactor, router: router)
        
        let mealNavigation = NavBarViewController(rootViewController: mealVC, tab: .meal)
        let drinkNavigation = NavBarViewController(rootViewController: drinkVC, tab: .drink)
        let favoritesNavigation = NavBarViewController(rootViewController: favoritesVC, tab: .favorites)
        
        presenter.view  = favoritesNavigation
        favoritesNavigation.presenter = presenter
        interactor.presenter = presenter
        router.viewController = favoritesNavigation
        
        return [mealNavigation, drinkNavigation, favoritesNavigation]
    }
}
