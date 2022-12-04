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
    func viewInput() {
        interactor.loadMeal()
    }
    
    func viewDidLoaded() {
        interactor.loadMeal()
    }
    
    func didLoad(meal: Meal) {
        let presentedMeal = ParcedMeal(strMeal: meal.meals[0]["strMeal"]!!,
                                       strCategory: meal.meals[0]["strCategory"]!!,
                                       strArea: meal.meals[0]["strArea"]!!,
                                       strYoutube: meal.meals[0]["strYoutube"]!!,
                                         strInstructions: meal.meals[0]["strInstructions"]!!,
                                         image: meal.meals[0]["strMealThumb"]!!,
                                         strIngridients: [meal.meals[0]["strIngredient1"] ?? "",
                                                          meal.meals[0]["strIngredient2"] ?? "",
                                                          meal.meals[0]["strIngredient3"] ?? "",
                                                          meal.meals[0]["strIngredient4"] ?? "",
                                                          meal.meals[0]["strIngredient5"] ?? "",
                                                          meal.meals[0]["strIngredient6"] ?? "",
                                                          meal.meals[0]["strIngredient7"] ?? "",
                                                          meal.meals[0]["strIngredient8"] ?? "",
                                                          meal.meals[0]["strIngredient9"] ?? "",
                                                          meal.meals[0]["strIngredient10"] ?? "",
                                                          meal.meals[0]["strIngredient11"] ?? "",
                                                          meal.meals[0]["strIngredient12"] ?? "",
                                                          meal.meals[0]["strIngredient13"] ?? "",
                                                          meal.meals[0]["strIngredient14"] ?? "",
                                                          meal.meals[0]["strIngredient15"] ?? "",
                                                          meal.meals[0]["strIngredient16"] ?? "",
                                                          meal.meals[0]["strIngredient17"] ?? "",
                                                          meal.meals[0]["strIngredient18"] ?? "",
                                                          meal.meals[0]["strIngredient19"] ?? "",
                                                          meal.meals[0]["strIngredient20"] ?? ""],
                                         strMeasure: [meal.meals[0]["strMeasure1"] ?? "",
                                                      meal.meals[0]["strMeasure2"] ?? "",
                                                      meal.meals[0]["strMeasure3"] ?? "",
                                                      meal.meals[0]["strMeasure4"] ?? "",
                                                      meal.meals[0]["strMeasure5"] ?? "",
                                                      meal.meals[0]["strMeasure6"] ?? "",
                                                      meal.meals[0]["strMeasure7"] ?? "",
                                                      meal.meals[0]["strMeasure8"] ?? "",
                                                      meal.meals[0]["strMeasure9"] ?? "",
                                                      meal.meals[0]["strMeasure10"] ?? "",
                                                      meal.meals[0]["strMeasure11"] ?? "",
                                                      meal.meals[0]["strMeasure12"] ?? "",
                                                      meal.meals[0]["strMeasure13"] ?? "",
                                                      meal.meals[0]["strMeasure14"] ?? "",
                                                      meal.meals[0]["strMeasure15"] ?? "",
                                                      meal.meals[0]["strMeasure16"] ?? "",
                                                      meal.meals[0]["strMeasure17"] ?? "",
                                                      meal.meals[0]["strMeasure18"] ?? "",
                                                      meal.meals[0]["strMeasure19"] ?? "",
                                                      meal.meals[0]["strMeasure20"] ?? ""])
        
        let mealDiscription = "Meal: \(presentedMeal.strMeal)\n\n"
        let categoryDiscription = "Category: \(presentedMeal.strCategory), \(presentedMeal.strArea)\n\n"
        var ingridientsDiscription = "Ingridients: \(presentedMeal.strIngridients[0] ?? "") \(presentedMeal.strMeasure[0] ?? ""), \(presentedMeal.strIngridients[1] ?? "") \(presentedMeal.strMeasure[1] ?? ""), \(presentedMeal.strIngridients[2] ?? "") \(presentedMeal.strMeasure[2] ?? ""), \(presentedMeal.strIngridients[3] ?? "") \(presentedMeal.strMeasure[3] ?? ""), \(presentedMeal.strIngridients[4] ?? "") \(presentedMeal.strMeasure[4] ?? ""), \(presentedMeal.strIngridients[5] ?? "") \(presentedMeal.strMeasure[5] ?? ""), \(presentedMeal.strIngridients[6] ?? "") \(presentedMeal.strMeasure[6] ?? ""), \(presentedMeal.strIngridients[7] ?? "") \(presentedMeal.strMeasure[7] ?? ""), \(presentedMeal.strIngridients[8] ?? "") \(presentedMeal.strMeasure[8] ?? ""), \(presentedMeal.strIngridients[9] ?? "") \(presentedMeal.strMeasure[9] ?? ""), \(presentedMeal.strIngridients[10] ?? "") \(presentedMeal.strMeasure[10] ?? ""), \(presentedMeal.strIngridients[11] ?? "") \(presentedMeal.strMeasure[11] ?? ""), \(presentedMeal.strIngridients[12] ?? "") \(presentedMeal.strMeasure[12] ?? ""), \(presentedMeal.strIngridients[13] ?? "") \(presentedMeal.strMeasure[13] ?? ""), \(presentedMeal.strIngridients[14] ?? "") \(presentedMeal.strMeasure[14] ?? ""), \(presentedMeal.strIngridients[15] ?? "") \(presentedMeal.strMeasure[15] ?? ""), \(presentedMeal.strIngridients[16] ?? "") \(presentedMeal.strMeasure[16] ?? ""), \(presentedMeal.strIngridients[17] ?? "") \(presentedMeal.strMeasure[17] ?? ""), \(presentedMeal.strIngridients[18] ?? "") \(presentedMeal.strMeasure[18] ?? ""), \(presentedMeal.strIngridients[19] ?? "") \(presentedMeal.strMeasure[19] ?? "")"
        let instructionDiscription = "Instructions: \(presentedMeal.strInstructions)"
        // MARK: rework
        while ingridientsDiscription.last == "\r" || ingridientsDiscription.last == "\n" || ingridientsDiscription.last == " " || ingridientsDiscription.last == "," {
            ingridientsDiscription.removeLast()
        }
        ingridientsDiscription += "\n\n"
        
        let imageURL = URL(string: presentedMeal.image)
        let data = try? Data(contentsOf: imageURL!)
        let image = UIImage(data: data!)!
        view?.viewInput(discription: mealDiscription + categoryDiscription + ingridientsDiscription + instructionDiscription, image: image)
    }
}
