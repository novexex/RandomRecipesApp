//
//  MealBuilder.swift
//  testSfera
//
//  Created by Artour Ilyasov on 01.12.2022
//

public class MealBuilder {
    public func build(favoritesVC: FavoritesViewController) -> MealViewController {
        let interactor = MealInteractor()
        let router = MealRouter()
        let presenter = MealPresenter(interactor: interactor, router: router)
        let viewController = MealViewController()
        presenter.view  = viewController
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.presenter = presenter
        
        return viewController
    }
    
    public init() {}
}
