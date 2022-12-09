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
        var presentedMeal = ParcedMeal()
        for (key, value) in meal.meals[0] {
            if let newValue = value { presentedMeal.data.updateValue(newValue, forKey: key) }
        }
        
//        print("\(presentedMeal.data)\n\n\n")
        
        let drinkDiscription = "Meal: \(presentedMeal.data[DictValues.Meal.name] ?? "")\n\n"
        let categoryDiscription = "Category: \(presentedMeal.data[DictValues.category] ?? ""), \(presentedMeal.data[DictValues.Meal.area] ?? "")\n\n"
        
        var ingredientsDiscription = """
        Ingredients:
        \(presentedMeal.data[DictValues.ingr1] ?? "del"): \(presentedMeal.data[DictValues.meas1] ?? "del"),
        \(presentedMeal.data[DictValues.ingr2] ?? "del"): \(presentedMeal.data[DictValues.meas2] ?? "del"),
        \(presentedMeal.data[DictValues.ingr3] ?? "del"): \(presentedMeal.data[DictValues.meas3] ?? "del"),
        \(presentedMeal.data[DictValues.ingr4] ?? "del"): \(presentedMeal.data[DictValues.meas4] ?? "del"),
        \(presentedMeal.data[DictValues.ingr5] ?? "del"): \(presentedMeal.data[DictValues.meas5] ?? "del"),
        \(presentedMeal.data[DictValues.ingr6] ?? "del"): \(presentedMeal.data[DictValues.meas6] ?? "del"),
        \(presentedMeal.data[DictValues.ingr7] ?? "del"): \(presentedMeal.data[DictValues.meas7] ?? "del"),
        \(presentedMeal.data[DictValues.ingr8] ?? "del"): \(presentedMeal.data[DictValues.meas8] ?? "del"),
        \(presentedMeal.data[DictValues.ingr9] ?? "del"): \(presentedMeal.data[DictValues.meas9] ?? "del"),
        \(presentedMeal.data[DictValues.ingr10] ?? "del"): \(presentedMeal.data[DictValues.meas10] ?? "del"),
        \(presentedMeal.data[DictValues.ingr11] ?? "del"): \(presentedMeal.data[DictValues.meas11] ?? "del"),
        \(presentedMeal.data[DictValues.ingr12] ?? "del"): \(presentedMeal.data[DictValues.meas12] ?? "del"),
        \(presentedMeal.data[DictValues.ingr13] ?? "del"): \(presentedMeal.data[DictValues.meas13] ?? "del"),
        \(presentedMeal.data[DictValues.ingr14] ?? "del"): \(presentedMeal.data[DictValues.meas14] ?? "del"),
        \(presentedMeal.data[DictValues.ingr15] ?? "del"): \(presentedMeal.data[DictValues.meas15] ?? "del"),
        \(presentedMeal.data[DictValues.ingr16] ?? "del"): \(presentedMeal.data[DictValues.meas16] ?? "del"),
        \(presentedMeal.data[DictValues.ingr17] ?? "del"): \(presentedMeal.data[DictValues.meas17] ?? "del"),
        \(presentedMeal.data[DictValues.ingr18] ?? "del"): \(presentedMeal.data[DictValues.meas18] ?? "del"),
        \(presentedMeal.data[DictValues.ingr19] ?? "del"): \(presentedMeal.data[DictValues.meas19] ?? "del"),
        \(presentedMeal.data[DictValues.ingr20] ?? "del"): \(presentedMeal.data[DictValues.meas20] ?? "del"),
        """
        
        let instructionDiscription = "\n\nInstructions:\n\(presentedMeal.data[DictValues.instruct] ?? "")"
        
//        print("\(ingredientsDiscription)\n\n\n")
    
        ingredientsDiscription.formatting()
        
//        print(ingredientsDiscription)

        guard let dictImage = presentedMeal.data[DictValues.Meal.image] else { return }
        let imageURL = URL(string: dictImage)

        guard let imageURL else { return }
        let data = try? Data(contentsOf: imageURL)

        guard let data else { return }
        let image = UIImage(data: data)
        
        if let image {
            view?.viewInput(discription: drinkDiscription + categoryDiscription + ingredientsDiscription + instructionDiscription, image: image)
        }
    }
}

