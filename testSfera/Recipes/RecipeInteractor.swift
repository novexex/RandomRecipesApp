//
//  RecipeInteractor.swift
//  testSfera
//
//  Created by Artour Ilyasov on 28.11.2022.
//

import Foundation

protocol RecipeInteractorProtocol: AnyObject {
    func loadMeal()
    func loadCocktail()
}

class RecipeInteractor: RecipeInteractorProtocol {
    weak var presenter: RecipePresenterProtocol?
    let mealService = Meal()
    let drinkService = Drink()
    
    func loadMeal() {
        //тут буду подтягивать данные с апи
    }
    
    func loadCocktail() {
        //тут буду подтягивать данные с апи
    }
    
}
