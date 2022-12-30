//
//  MealInteractor.swift
//  testSfera
//
//  Created by Artour Ilyasov on 01.12.2022
//

protocol MealInteractorProtocol: AnyObject {
    func loadMeal()
}

class MealInteractor {
    weak var presenter: MealPresenterProtocol?
    let randomMealService = RandomMealService()
}

extension MealInteractor: MealInteractorProtocol {
    func loadMeal() {
        randomMealService.getDate { [weak self] meal in
            self?.presenter?.interactorDidLoad(meal: meal)
        }
    }
}
