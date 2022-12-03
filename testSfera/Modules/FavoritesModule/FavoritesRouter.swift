//
//  FavoritesRouter.swift
//  Super easy dev
//
//  Created by Artour Ilyasov on 01.12.2022
//

import UIKit

protocol FavoritesRouterProtocol {
}

class FavoritesRouter: FavoritesRouterProtocol {
    weak var viewController: FavoritesViewController?
    
//    func setupFavoritesView() -> NavBarViewController {
//        let favoritesController = FavoritesViewController()
//        let favoritesNavigation = NavBarViewController(rootViewController: favoritesController)
//        favoritesNavigation.tabBarItem = UITabBarItem(title: Resources.Titles.TabBar.favorites,
//                                                      image: Resources.Images.favorites,
//                                                      tag: Tabs.favorites.rawValue)
//        return favoritesNavigation
//    }
}
