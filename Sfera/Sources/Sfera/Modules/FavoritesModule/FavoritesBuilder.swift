//
//  FavoritesBuilder.swift
//  testSfera
//
//  Created by Artour Ilyasov on 01.12.2022
//

public class FavoritesBuilder {
    public func build() -> FavoritesViewController {
        let interactor = FavoritesInteractor()
        let router = FavoritesRouter()
        let presenter = FavoritesPresenter(interactor: interactor, router: router)
        let viewController = FavoritesViewController()
        presenter.view  = viewController
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.presenter = presenter
        
        return viewController
    }
    
    public init() {}
}
