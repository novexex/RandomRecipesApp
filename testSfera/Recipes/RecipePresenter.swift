//
//  RecipePresenter.swift
//  testSfera
//
//  Created by Artour Ilyasov on 28.11.2022.
//

import Foundation

protocol RecipePresenterProtocol: AnyObject {
    func viewDidLoaded()
    func didLoad(meal: Meal)
    func didLoad(drink: Drink)
}

class RecipePresenter {
    weak var view: RecipeViewProtocol?
    var router: RecipeRouterProtocol
    var interactor: RecipeInteractorProtocol
    
    init(router: RecipeRouterProtocol, interactor: RecipeInteractorProtocol) {
        self.router = router
        self.interactor = interactor
    }
}

extension RecipePresenter: RecipePresenterProtocol {
    func didLoad(meal: Meal) {
        //
    }
    
    func didLoad(drink: Drink) {
        //
    }
    
    func viewDidLoaded() {
        interactor.loadMeal()
        interactor.loadCocktail()
    }
}
