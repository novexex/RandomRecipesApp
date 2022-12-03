//
//  TabBarViewController.swift
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

protocol TabBarBaseViewProtocol: AnyObject {
    func setViews(mealNavigation: NavBarViewController,
                  drinkNavigation: NavBarViewController,
                  favoritesNavigation: NavBarViewController)
    func viewInput()
    func viewOutput()
}

final class TabBarViewController: UITabBarController {

    var presenter: TabBarPresenterProtocol? {
        didSet {
            presenter?.viewDidLoaded()
        }
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
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
    }
}

extension TabBarViewController: TabBarBaseViewProtocol {
    func viewInput() {
        
    }
    
    func viewOutput() {
        
    }
    
    func setViews(mealNavigation: NavBarViewController,
                  drinkNavigation: NavBarViewController,
                  favoritesNavigation: NavBarViewController) {
        setViewControllers([mealNavigation, drinkNavigation, favoritesNavigation], animated: false)
    }
}
