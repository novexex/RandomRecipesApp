//
//  AppDelegate.swift
//  testSfera
//
//  Created by Artour Ilyasov on 28.11.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let favoritesVC = FavoritesBuilder.build()
        let mealVC = MealBuilder.build(favoritesVC: favoritesVC)
        let drinkVC = DrinkBuilder.build(favoritesVC: favoritesVC)
        let navArray = NavBarBuilder.build(mealVC: mealVC, drinkVC: drinkVC, favoritesVC: favoritesVC)
        let tabBarController = UITabBarController()
        tabBarController.setViewControllers(navArray, animated: false)
        tabBarController.tabBar.backgroundColor = .white
        window = UIWindow()
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        //StorageManager.saveContext()
    }
}
