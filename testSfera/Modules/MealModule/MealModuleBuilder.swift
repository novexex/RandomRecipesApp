//
//  MealModuleBuilder.swift
//  Super easy dev
//
//  Created by Artour Ilyasov on 01.12.2022
//

import UIKit

class MealModuleBuilder {
    static func build() -> MealViewController {
        let interactor = MealInteractor()
        let router = MealRouter()
        let presenter = MealPresenter(interactor: interactor, router: router)
        let viewController = MealViewController()
        
        let mealNavigation = NavBarViewController(rootViewController: viewController)
//        mealNavigation.tabBarItem = UITabBarItem(title: Resources.Titles.TabBar.meal,
//                                                 image: Resources.Images.meal,
//                                                 tag: Tabs.meal.rawValue)
        
        
        presenter.view  = viewController
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        
        return viewController
    }
}
