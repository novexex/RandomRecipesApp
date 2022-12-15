//
//  DrinkPresenter.swift
//  testSfera
//
//  Created by Artour Ilyasov on 01.12.2022
//

import UIKit

protocol DrinkPresenterProtocol: AnyObject {
    func viewDidLoaded()
    func interactorDidLoad(drink: Drink)
    func viewOutput()
    func buttonSavePressed()
    func buttonNextPressed()
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
    func viewDidLoaded() {
        view?.startActivityIndicator()
        viewOutput()
    }
    
    func interactorDidLoad(drink: Drink) {
        let presentedDrink = ParcedDrink(strDrink: (drink.drinks[0][DictKeys.Drink.name] ?? "") ?? "",
                                         strAlcoholic: (drink.drinks[0][DictKeys.Drink.alco] ?? "") ?? "",
                                         image: (drink.drinks[0][DictKeys.Drink.image] ?? "") ?? "",
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
        let instructionDiscription = presentedDrink.instructions.isEmpty ? "" : "\n\nInstructions:\n\(presentedDrink.instructions)"
        var ingredientsDiscription = "Ingredients:\n"
        
        for (index, _) in presentedDrink.ingredients.enumerated() {
            ingredientsDiscription += "\(presentedDrink.ingredients[index] ?? "del"): \(presentedDrink.measure[index] ?? "del"),\n"
        }
        
        ingredientsDiscription.formatting()
        
        DispatchQueue.main.async {
            let imageView = UIImageView().getImageFromURL(url: presentedDrink.image)
            self.view?.viewInput(description: drinkDiscription + categoryDiscription + ingredientsDiscription + instructionDiscription,
                                 image: imageView)
        }
    }
    func viewOutput() {
        interactor.loadCocktail()
    }
    
    func buttonNextPressed() {
        view?.refreshView()
        view?.startActivityIndicator()
        viewOutput()
    }
    
    func buttonSavePressed() {
        guard let lastLoadedDrink else { return }
        router.post(drink: lastLoadedDrink)
    }
}
