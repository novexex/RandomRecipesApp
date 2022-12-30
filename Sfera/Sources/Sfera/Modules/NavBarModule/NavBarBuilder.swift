//
//  NavBarBuilder.swift
//  testSfera
//
//  Created by Artour Ilyasov on 01.12.2022
//

public class NavBarBuilder {
    public func build(mealVC: MealViewController,
                      drinkVC: DrinkViewController,
                      favoritesVC: FavoritesViewController) -> [NavBarViewController] {
        let interactor = NavBarInteractor()
        let router = NavBarRouter()
        let presenter = NavBarPresenter(interactor: interactor, router: router)
        
        let mealNavigation = NavBarViewController(rootViewController: mealVC, tab: .meal)
        let drinkNavigation = NavBarViewController(rootViewController: drinkVC, tab: .drink)
        let favoritesNavigation = NavBarViewController(rootViewController: favoritesVC, tab: .favorites)
        
        presenter.view = favoritesNavigation
        favoritesNavigation.presenter = presenter
        interactor.presenter = presenter
        router.presenter = presenter
        
        return [mealNavigation, drinkNavigation, favoritesNavigation]
    }
    
    public init() {}
}
