//
//  MealPresenter.swift
//  testSfera
//
//  Created by Artour Ilyasov on 01.12.2022
//

import UIKit

protocol MealPresenterProtocol: AnyObject {
    func viewDidLoaded()
    func didLoad(meal: Meal)
    func viewInput()
    func buttonSaveTapped()
}

class MealPresenter {
    weak var view: MealViewProtocol?
    var router: MealRouterProtocol
    var interactor: MealInteractorProtocol
    var lastLoadedMeal: ParcedMeal?
    
    init(interactor: MealInteractorProtocol, router: MealRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension MealPresenter: MealPresenterProtocol {
    func buttonSaveTapped() {
        guard let lastLoadedMeal else { return }
        router.buttonSavePressed(meal: lastLoadedMeal)
    }
    
    func viewInput() {
        interactor.loadMeal()
    }
    
    func viewDidLoaded() {
        interactor.loadMeal()
    }
    
    func didLoad(meal: Meal) {
        let presentedMeal = ParcedMeal(strMeal: (meal.meals[0][DictKeys.Meal.name] ?? "") ?? "",
                                             strArea: (meal.meals[0][DictKeys.Meal.area] ?? "") ?? "",
                                            image: (meal.meals[0][DictKeys.Meal.image] ?? "") ?? "",
                                             category: (meal.meals[0][DictKeys.category] ?? "") ?? "",
                                             instructions: (meal.meals[0][DictKeys.instruct] ?? "") ?? "")
        for i in DictKeys.ingr {
            presentedMeal.ingredients.append(meal.meals[0][i] ?? nil)
        }
        for i in DictKeys.meas {
            presentedMeal.measure.append(meal.meals[0][i] ?? nil)
        }
        lastLoadedMeal = presentedMeal
        
        let mealDiscription = "Meal: \(presentedMeal.strMeal)\n\n"
        let categoryDiscription = "Category: \(presentedMeal.category), \(presentedMeal.strArea)\n\n"
        let instructionDiscription = "\n\nInstructions:\n\(presentedMeal.instructions)"
        var ingredientsDiscription = ""
        
        for (index, _) in presentedMeal.ingredients.enumerated() {
            ingredientsDiscription += "\(presentedMeal.ingredients[index] ?? "del"): \(presentedMeal.measure[index] ?? "del"),\n"
        }
        
        ingredientsDiscription.formatting()

        let image = UIImage().getImageFromString(url: presentedMeal.image)
        
        view?.viewInput(description: mealDiscription + categoryDiscription + ingredientsDiscription + instructionDiscription,
                        image: image)
    }
}

