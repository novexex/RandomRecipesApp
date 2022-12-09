//
//  FavoritesPresenter.swift
//  testSfera
//
//  Created by Artour Ilyasov on 01.12.2022
//

protocol FavoritesPresenterProtocol: AnyObject {
    func viewInput(drink: ParcedDrink)
    func viewInput(meal: ParcedMeal)
    func viewOutput(drink: ParcedDrink)
    func viewOutput(meal: ParcedMeal)
}

class FavoritesPresenter {
    weak var view: FavoritesViewProtocol?
    var router: FavoritesRouterProtocol
    var interactor: FavoritesInteractorProtocol

    init(interactor: FavoritesInteractorProtocol, router: FavoritesRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension FavoritesPresenter: FavoritesPresenterProtocol {
    func viewInput(drink: ParcedDrink) {
        
    }
    
    func viewInput(meal: ParcedMeal) {
        
    }
    
    func viewOutput(drink: ParcedDrink) {
        
    }
    
    func viewOutput(meal: ParcedMeal) {
        
    }
    
}
