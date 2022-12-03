//
//  NavBarViewController.swift
//  Super easy dev
//
//  Created by Artour Ilyasov on 01.12.2022
//

import UIKit

protocol NavBarViewProtocol: AnyObject {}

class NavBarViewController: UINavigationController {
    // MARK: - Public
    var presenter: NavBarPresenterProtocol?
    
    convenience init(rootViewController: UIViewController, tab: Tabs) {
        self.init(rootViewController: rootViewController)
        configureNavigation(tab: tab)
    }
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}

// MARK: - Private functions
private extension NavBarViewController {
    func configure() {
        view.backgroundColor = .white
        navigationBar.isTranslucent = false
        navigationBar.standardAppearance.titleTextAttributes = [
            .foregroundColor: Resources.Colors.titleGray,
            .font: Resources.Fonts.helveticaRegular(with: 17)
        ]
        navigationBar.addButtonBorder(with: Resources.Colors.separator, height: 1)
    }
    
    func configureNavigation(tab: Tabs) {
        switch tab {
        case .meal:
            self.tabBarItem = UITabBarItem(title: Resources.Titles.TabBar.meal,
                                               image: Resources.Images.meal,
                                               tag: Tabs.meal.rawValue)
        case .drink:
            self.tabBarItem = UITabBarItem(title: Resources.Titles.TabBar.drink,
                                               image: Resources.Images.drink,
                                               tag: Tabs.drink.rawValue)
        case .favorites:
            self.tabBarItem = UITabBarItem(title: Resources.Titles.TabBar.favorites,
                                               image: Resources.Images.favorites,
                                               tag: Tabs.favorites.rawValue)
        }
    }
    
}

// MARK: - NavBarViewProtocol
extension NavBarViewController: NavBarViewProtocol {
}
