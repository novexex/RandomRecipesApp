//
//  MealRouter.swift
//  Super easy dev
//
//  Created by Artour Ilyasov on 01.12.2022
//

import UIKit

protocol MealRouterProtocol {
}

class MealRouter: MealRouterProtocol {
    weak var viewController: MealViewController?
    
//    func setupMealView() -> NavBarViewController {
//        let mealController = MealViewController()
//        let mealNavigation = NavBarViewController(rootViewController: mealController)
//        mealNavigation.tabBarItem = UITabBarItem(title: Resources.Titles.TabBar.meal,
//                                                 image: Resources.Images.meal,
//                                                 tag: Tabs.meal.rawValue)
//        return mealNavigation
//    }
    
}
