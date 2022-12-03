//
//  TabBarRouter.swift
//  testSfera
//
//  Created by Artour Ilyasov on 28.11.2022.
//

import Foundation
import UIKit

protocol TabBarRouterProtocol: AnyObject {
    func setupViews()
}

class TabBarRouter: TabBarRouterProtocol {
    weak var viewController: TabBarController?
    
    func setupViews() {
        let mealVC = MealModuleBuilder.build()
        let drinkVC = DrinkModuleBuilder.build()
        let favoritesVC = FavoritesModuleBuilder.build()
        
        let navArray = NavBarModuleBuilder.build(mealVC: mealVC, drinkVC: drinkVC, favoritesVC: favoritesVC)
        
        viewController?.setViews(mealNavigation: navArray[0], drinkNavigation: navArray[1], favoritesNavigation: navArray[2])
    }
}
