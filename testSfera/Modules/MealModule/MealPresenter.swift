//
//  MealPresenter.swift
//  testSfera
//
//  Created by Artour Ilyasov on 01.12.2022
//

import UIKit

protocol MealPresenterProtocol: AnyObject {
    func viewDidLoaded()
    func interactorDidLoad(meal: Meal)
    func viewOutput()
    func buttonSavePressed()
    func buttonNextPressed()
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
    func viewDidLoaded() {
        view?.startActivityIndicator()
        viewOutput()
    }
    
    func interactorDidLoad(meal: Meal) {
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
        var ingredientsDiscription = "Ingredients:\n"
        
        for (index, _) in presentedMeal.ingredients.enumerated() {
            ingredientsDiscription += "\(presentedMeal.ingredients[index] ?? "del"): \(presentedMeal.measure[index] ?? "del"),\n"
        }
        
        ingredientsDiscription.formatting()
        
        DispatchQueue.main.async {
            let image = UIImageView().getImageFromURL(url: presentedMeal.image)
            self.view?.viewInput(description: mealDiscription + categoryDiscription + ingredientsDiscription + instructionDiscription,
                                 image: image)
        }
    }
    
    func viewOutput() {
        interactor.loadMeal()
    }
    
    func buttonNextPressed() {
        view?.refreshView()
        view?.startActivityIndicator()
        viewOutput()
    }
    
    func buttonSavePressed() {
        guard let lastLoadedMeal else { return }
        router.buttonSavePressed(meal: lastLoadedMeal)
    }
}
