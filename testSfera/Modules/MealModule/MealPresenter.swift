//
//  MealPresenter.swift
//  Super easy dev
//
//  Created by Artour Ilyasov on 01.12.2022
//

protocol MealPresenterProtocol: AnyObject {
    func viewDidLoaded()
    func didLoad(meal: Meal)
}

class MealPresenter {
    weak var view: MealViewProtocol?
    var router: MealRouterProtocol
    var interactor: MealInteractorProtocol

    init(interactor: MealInteractorProtocol, router: MealRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension MealPresenter: MealPresenterProtocol {
    func viewDidLoaded() {
        interactor.loadMeal()
    }
    
    func didLoad(meal: Meal) {
        print(meal.meals[0]["strMeal"]!!)
    }
}
