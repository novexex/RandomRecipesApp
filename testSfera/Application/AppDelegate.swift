//
//  AppDelegate.swift
//  testSfera
//
//  Created by Artour Ilyasov on 28.11.2022.
//

import UIKit
import Sfera

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let favoritesBuilder = FavoritesBuilder()
        let favoritesVC = favoritesBuilder.build()
        let mealBuilder = MealBuilder()
        let mealVC = mealBuilder.build(favoritesVC: favoritesVC)
        let drinkBuilder = DrinkBuilder()
        let drinkVC = drinkBuilder.build(favoritesVC: favoritesVC)
        let navBuilder = NavBarBuilder()
        let navArray = navBuilder.build(mealVC: mealVC, drinkVC: drinkVC, favoritesVC: favoritesVC)
        let tabBarController = UITabBarController()
        tabBarController.setViewControllers(navArray, animated: false)
        tabBarController.tabBar.backgroundColor = .white
        window = UIWindow()
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        return true
    }
}
