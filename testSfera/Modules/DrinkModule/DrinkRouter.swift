//
//  DrinkRouter.swift
//  Super easy dev
//
//  Created by Artour Ilyasov on 01.12.2022
//

import UIKit

protocol DrinkRouterProtocol {
}

class DrinkRouter: DrinkRouterProtocol {
    weak var viewController: DrinkViewController?
    
//    func setupDrinkView() -> NavBarViewController {
//        let drinkNavigation = NavBarViewController(rootViewController: viewController)
//        drinkNavigation.tabBarItem = UITabBarItem(title: Resources.Titles.TabBar.drink,
//                                                 image: Resources.Images.drink,
//                                                 tag: Tabs.drink.rawValue)
//        return drinkNavigation
//    }
}
