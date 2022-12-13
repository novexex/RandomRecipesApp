//
//  DrinkPresenter.swift
//  testSfera
//
//  Created by Artour Ilyasov on 01.12.2022
//

import UIKit

protocol DrinkPresenterProtocol: AnyObject {
    func viewDidLoaded()
    func didLoad(drink: Drink)
    func viewOutput()
    func buttonSavePressed()
    func callRouter()
}

class DrinkPresenter {
    weak var view: DrinkViewProtocol?
    var router: DrinkRouterProtocol
    var interactor: DrinkInteractorProtocol
    var lastLoadedDrink: ParcedDrink?
    
    init(interactor: DrinkInteractorProtocol, router: DrinkRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension DrinkPresenter: DrinkPresenterProtocol {
    func callRouter() {
        guard let lastLoadedDrink else { return }
        router.buttonSavePressed(drink: lastLoadedDrink)
    }
    
    func buttonSavePressed() {
        interactor.buttonSavePressed()
    }
    
    func viewOutput() {
        interactor.loadCocktail()
    }
    
    func viewDidLoaded() {
        interactor.loadCocktail()
    }
    
    func didLoad(drink: Drink) {
        // initialize model
        let presentedDrink = ParcedDrink(strDrink: (drink.drinks[0][DictKeys.Drink.name] ?? "") ?? "",
                                              strAlcoholic: (drink.drinks[0][DictKeys.Drink.alco] ?? "") ?? "",
                                              image: (drink.drinks[0][DictKeys.Drink.image] ?? "") ?? "",
                                              category: (drink.drinks[0][DictKeys.category] ?? "") ?? "",
                                              instructions: (drink.drinks[0][DictKeys.instruct] ?? "") ?? "")
        //fill arrays in model
        for i in DictKeys.ingr {
            presentedDrink.ingredients.append(drink.drinks[0][i] ?? nil)
        }
        for i in DictKeys.meas {
            presentedDrink.measure.append(drink.drinks[0][i] ?? nil)
        }

        lastLoadedDrink = presentedDrink
        
        //prepare for view
        let drinkDiscription = "Drink: \(presentedDrink.strDrink)\n\n"
        let categoryDiscription = "Category: \(presentedDrink.category), \(presentedDrink.strAlcoholic)\n\n"
        let instructionDiscription = "\n\nInstructions:\n\(presentedDrink.instructions)"
        var ingredientsDiscription = ""
        
        for (index, _) in presentedDrink.ingredients.enumerated() {
            ingredientsDiscription += "\(presentedDrink.ingredients[index] ?? "del"): \(presentedDrink.measure[index] ?? "del"),\n"
        }

        ingredientsDiscription.formatting()
        
        let image = UIImage().getImageFromString(url: presentedDrink.image)
        
        view?.viewInput(description: drinkDiscription + categoryDiscription + ingredientsDiscription + instructionDiscription,
                        image: image)
    }
}
