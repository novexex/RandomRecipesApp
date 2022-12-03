//
//  DrinkModuleBuilder.swift
//  Super easy dev
//
//  Created by Artour Ilyasov on 01.12.2022
//

import UIKit

class DrinkModuleBuilder {
    static func build() -> DrinkViewController {
        let interactor = DrinkInteractor()
        let router = DrinkRouter()
        let presenter = DrinkPresenter(interactor: interactor, router: router)
        
        let viewController = DrinkViewController()
//        let drinkNavigation = NavBarViewController(rootViewController: viewController)
//        drinkNavigation.tabBarItem = UITabBarItem(title: Resources.Titles.TabBar.drink,
//                                                 image: Resources.Images.drink,
//                                                 tag: Tabs.drink.rawValue)
        
        presenter.view  = viewController
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
