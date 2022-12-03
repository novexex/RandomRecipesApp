//
//  MealInteractor.swift
//  testSfera
//
//  Created by Artour Ilyasov on 01.12.2022
//

protocol MealInteractorProtocol: AnyObject {
    func loadMeal()
}

class MealInteractor: MealInteractorProtocol {
    weak var presenter: MealPresenterProtocol?
    
    let randomMealService = RandomMealService()
    
    func loadMeal() {
        randomMealService.getDate { [weak self] meal in
            self?.presenter?.didLoad(meal: meal)
        }
    }
}
