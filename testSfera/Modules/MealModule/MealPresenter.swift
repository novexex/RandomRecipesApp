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
    var lastLoadedMeal: ParcedMealClass?
    
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
        let presentedMeal = ParcedMealClass(strMeal: (meal.meals[0][DictKeys.Meal.name] ?? "") ?? "",
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
        
        let mealDiscription = "Drink: \(presentedMeal.strMeal)\n\n"
        let categoryDiscription = "Category: \(presentedMeal.category), \(presentedMeal.strArea)\n\n"
        let instructionDiscription = "\n\nInstructions:\n\(presentedMeal.instructions)"
        var ingredientsDiscription = ""
        
        for (index, _) in presentedMeal.ingredients.enumerated() {
            ingredientsDiscription += "\(presentedMeal.ingredients[index] ?? "del"): \(presentedMeal.measure[index] ?? "del"),\n"
        }
        
        ingredientsDiscription.formatting()
        
        let image = UIImage().getImageFromURL(url: presentedMeal.image)
        
        view?.viewInput(discription: mealDiscription + categoryDiscription + ingredientsDiscription + instructionDiscription,
                        image: image)
        
        
        // MARK: Dictionary style
        /*        var presentedMeal = ParcedMeal()
         for (key, value) in meal.meals[0] {
         if let newValue = value { presentedMeal.data.updateValue(newValue, forKey: key) }
         }
         
         //        print("\(presentedMeal.data)\n\n\n")
         
         let drinkDiscription = "Meal: \(presentedMeal.data[DictKeys.Meal.name] ?? "")\n\n"
         let categoryDiscription = "Category: \(presentedMeal.data[DictKeys.category] ?? ""), \(presentedMeal.data[DictKeys.Meal.area] ?? "")\n\n"
         
         var ingredientsDiscription = """
         Ingredients:
         \(presentedMeal.data[DictKeys.ingr1] ?? "del"): \(presentedMeal.data[DictKeys.meas1] ?? "del"),
         \(presentedMeal.data[DictKeys.ingr2] ?? "del"): \(presentedMeal.data[DictKeys.meas2] ?? "del"),
         \(presentedMeal.data[DictKeys.ingr3] ?? "del"): \(presentedMeal.data[DictKeys.meas3] ?? "del"),
         \(presentedMeal.data[DictKeys.ingr4] ?? "del"): \(presentedMeal.data[DictKeys.meas4] ?? "del"),
         \(presentedMeal.data[DictKeys.ingr5] ?? "del"): \(presentedMeal.data[DictKeys.meas5] ?? "del"),
         \(presentedMeal.data[DictKeys.ingr6] ?? "del"): \(presentedMeal.data[DictKeys.meas6] ?? "del"),
         \(presentedMeal.data[DictKeys.ingr7] ?? "del"): \(presentedMeal.data[DictKeys.meas7] ?? "del"),
         \(presentedMeal.data[DictKeys.ingr8] ?? "del"): \(presentedMeal.data[DictKeys.meas8] ?? "del"),
         \(presentedMeal.data[DictKeys.ingr9] ?? "del"): \(presentedMeal.data[DictKeys.meas9] ?? "del"),
         \(presentedMeal.data[DictKeys.ingr10] ?? "del"): \(presentedMeal.data[DictKeys.meas10] ?? "del"),
         \(presentedMeal.data[DictKeys.ingr11] ?? "del"): \(presentedMeal.data[DictKeys.meas11] ?? "del"),
         \(presentedMeal.data[DictKeys.ingr12] ?? "del"): \(presentedMeal.data[DictKeys.meas12] ?? "del"),
         \(presentedMeal.data[DictKeys.ingr13] ?? "del"): \(presentedMeal.data[DictKeys.meas13] ?? "del"),
         \(presentedMeal.data[DictKeys.ingr14] ?? "del"): \(presentedMeal.data[DictKeys.meas14] ?? "del"),
         \(presentedMeal.data[DictKeys.ingr15] ?? "del"): \(presentedMeal.data[DictKeys.meas15] ?? "del"),
         \(presentedMeal.data[DictKeys.ingr16] ?? "del"): \(presentedMeal.data[DictKeys.meas16] ?? "del"),
         \(presentedMeal.data[DictKeys.ingr17] ?? "del"): \(presentedMeal.data[DictKeys.meas17] ?? "del"),
         \(presentedMeal.data[DictKeys.ingr18] ?? "del"): \(presentedMeal.data[DictKeys.meas18] ?? "del"),
         \(presentedMeal.data[DictKeys.ingr19] ?? "del"): \(presentedMeal.data[DictKeys.meas19] ?? "del"),
         \(presentedMeal.data[DictKeys.ingr20] ?? "del"): \(presentedMeal.data[DictKeys.meas20] ?? "del"),
         """
         
         let instructionDiscription = "\n\nInstructions:\n\(presentedMeal.data[DictKeys.instruct] ?? "")"
         
         //        print("\(ingredientsDiscription)\n\n\n")
         
         ingredientsDiscription.formatting()
         
         //        print(ingredientsDiscription)
         
         guard let dictImage = presentedMeal.data[DictKeys.Meal.image] else { return }
         let imageURL = URL(string: dictImage)
         
         guard let imageURL else { return }
         let data = try? Data(contentsOf: imageURL)
         
         guard let data else { return }
         let image = UIImage(data: data)
         
         if let image {
         view?.viewInput(discription: drinkDiscription + categoryDiscription + ingredientsDiscription + instructionDiscription, image: image)
         }
         */
    }
}

