//
//  FavoritesModuleBuilder.swift
//  Super easy dev
//
//  Created by Artour Ilyasov on 01.12.2022
//

import UIKit

class FavoritesModuleBuilder {
    static func build() -> FavoritesViewController {
        let interactor = FavoritesInteractor()
        let router = FavoritesRouter()
        let presenter = FavoritesPresenter(interactor: interactor, router: router)
        let viewController = FavoritesViewController()
        
//        let favoritesNavigation = NavBarViewController(rootViewController: viewController)
//        favoritesNavigation.tabBarItem = UITabBarItem(title: Resources.Titles.TabBar.favorites,
//                                                      image: Resources.Images.favorites,
//                                                      tag: Tabs.favorites.rawValue)
        
        presenter.view  = viewController
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
