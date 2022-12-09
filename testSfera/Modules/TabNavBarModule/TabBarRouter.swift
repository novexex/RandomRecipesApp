//
//  TabBarRouter.swift
//  testSfera
//
//  Created by Artour Ilyasov on 28.11.2022.
//

protocol TabBarRouterProtocol: AnyObject {
    func setupViews()
}

class TabBarRouter: TabBarRouterProtocol {
    weak var viewController: TabBarViewController?
    
    func setupViews() {
        let favoritesVC = FavoritesBuilder.build()
        let mealVC = MealBuilder.build()
        let drinkVC = DrinkBuilder.build(favoritesVC: favoritesVC)
        
        let navArray = NavBarBuilder.build(mealVC: mealVC, drinkVC: drinkVC, favoritesVC: favoritesVC)
        
        viewController?.setViews(mealNavigation: navArray[0], drinkNavigation: navArray[1], favoritesNavigation: navArray[2])
    }
}
