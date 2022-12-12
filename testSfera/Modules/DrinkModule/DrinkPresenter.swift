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
    func showAlert()
    var countOfSaveButtonPress: Int { get set }
}

class DrinkPresenter {
    weak var view: DrinkViewProtocol?
    var router: DrinkRouterProtocol
    var interactor: DrinkInteractorProtocol
    var lastLoadedDrink: ParcedDrinkClass?
    var countOfSaveButtonPress = 0
    
    init(interactor: DrinkInteractorProtocol, router: DrinkRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension DrinkPresenter: DrinkPresenterProtocol {
    func showAlert() {
        let alert = UIAlertController(title: "Error", message: "This recipe is already saved", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default))
        view?.showAlert(alert: alert)
    }
    
    func callRouter() {
        guard let lastLoadedDrink else { return }
        router.buttonSavePressed(drink: lastLoadedDrink)
    }
    
    func buttonSavePressed() {
        countOfSaveButtonPress += 1
        interactor.buttonSavePressed()
    }
    
    func viewOutput() {
        interactor.loadCocktail()
    }
    
    func viewDidLoaded() {
        interactor.loadCocktail()
    }
    
    func didLoad(drink: Drink) {
        let presentedDrink = ParcedDrinkClass(strDrink: (drink.drinks[0][DictKeys.Drink.name] ?? "") ?? "",
                                              strAlcoholic: (drink.drinks[0][DictKeys.Drink.alco] ?? "") ?? "",
                                              image: UIImage().getImageFromURL(url: (drink.drinks[0][DictKeys.Drink.image] ?? "") ?? ""),
                                              category: (drink.drinks[0][DictKeys.category] ?? "") ?? "",
                                              instructions: (drink.drinks[0][DictKeys.instruct] ?? "") ?? "")
        for i in DictKeys.ingr {
            presentedDrink.ingredients.append(drink.drinks[0][i] ?? nil)
        }
        for i in DictKeys.meas {
            presentedDrink.measure.append(drink.drinks[0][i] ?? nil)
        }

        lastLoadedDrink = presentedDrink
        
        let drinkDiscription = "Drink: \(presentedDrink.strDrink)\n\n"
        let categoryDiscription = "Category: \(presentedDrink.category), \(presentedDrink.strAlcoholic)\n\n"
        let instructionDiscription = "\n\nInstructions:\n\(presentedDrink.instructions)"
        var ingredientsDiscription = ""
        
        for (index, _) in presentedDrink.ingredients.enumerated() {
            ingredientsDiscription += "\(presentedDrink.ingredients[index] ?? "del"): \(presentedDrink.measure[index] ?? "del"),\n"
        }

        ingredientsDiscription.formatting()
        
        view?.viewInput(description: drinkDiscription + categoryDiscription + ingredientsDiscription + instructionDiscription,
                        image: presentedDrink.image)
        }
    }
