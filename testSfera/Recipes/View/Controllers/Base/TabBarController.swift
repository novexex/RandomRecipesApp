//
//  TabBarController.swift
//  testSfera
//
//  Created by Artour Ilyasov on 30.11.2022.
//

import UIKit

enum Tabs: Int {
    case meal
    case drink
    case favorites
}

protocol RecipeBaseViewProtocol: AnyObject {
    
}

final class TabBarController: UITabBarController {
    
    var presenter: RecipePresenterProtocol?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        presenter?.viewDidLoaded()
        configureAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureAppearance() {
        tabBar.tintColor = Resources.Colors.active
        tabBar.barTintColor = Resources.Colors.inActive
        tabBar.backgroundColor = .white
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = nil
        } else {
            // я не ебу как сделать на 13 оси
        }
        
        tabBar.layer.borderColor = Resources.Colors.separator.cgColor
        tabBar.layer.borderWidth = 1
        tabBar.layer.masksToBounds = true
        
        let mealController = MealController()
        let drinkController = DrinkController()
        let favoritesController = FavoritesController()
        
        let mealNavigation = NavBarController(rootViewController: mealController)
        let drinkNavigation = NavBarController(rootViewController: drinkController)
        let favoritesNavigation = NavBarController(rootViewController: favoritesController)
        
        mealNavigation.tabBarItem = UITabBarItem(title: Resources.Titles.TabBar.meal,
                                                 image: Resources.Images.meal,
                                                 tag: Tabs.meal.rawValue)
        
        drinkNavigation.tabBarItem = UITabBarItem(title: Resources.Titles.TabBar.drink,
                                                 image: Resources.Images.drink,
                                                 tag: Tabs.drink.rawValue)
        favoritesNavigation.tabBarItem = UITabBarItem(title: Resources.Titles.TabBar.favorites,
                                                      image: Resources.Images.favorites,
                                                      tag: Tabs.favorites.rawValue)
        
        setViewControllers([mealNavigation, drinkNavigation, favoritesNavigation], animated: false)
    }
}

extension TabBarController: RecipeBaseViewProtocol {
    
}
