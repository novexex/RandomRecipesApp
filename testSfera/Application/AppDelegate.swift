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

        let tabBarController = TabBarBuilder.build()
        window = UIWindow()
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()

        return true
    }
}

