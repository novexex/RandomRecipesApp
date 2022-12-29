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
        let presentedDrink = ParcedDrink(strDrink: (drink.drinks[0][Resources.DictKeys.Drink.name] ?? Resources.empty) ?? Resources.empty,
                                         strAlcoholic: (drink.drinks[0][Resources.DictKeys.Drink.alco] ?? Resources.empty) ?? Resources.empty,
                                         image: (drink.drinks[0][Resources.DictKeys.Drink.image] ?? Resources.empty) ?? Resources.empty,
                                         category: (drink.drinks[0][Resources.DictKeys.category] ?? Resources.empty) ?? Resources.empty,
                                         instructions: (drink.drinks[0][Resources.DictKeys.instruct] ?? Resources.empty) ?? Resources.empty)
        for i in Resources.DictKeys.ingr {
            presentedDrink.ingredients.append(drink.drinks[0][i] ?? nil)
        }
        for i in Resources.DictKeys.meas {
            presentedDrink.measure.append(drink.drinks[0][i] ?? nil)
        }
        
        lastLoadedDrink = presentedDrink

        let drinkDiscription = "Drink: \(presentedDrink.strDrink)\n\n"
        let categoryDiscription = "Category: \(presentedDrink.category), \(presentedDrink.strAlcoholic)\n\n"
        let instructionDiscription = presentedDrink.instructions.isEmpty ? Resources.empty : "\n\nInstructions:\n\(presentedDrink.instructions)"
        var ingredientsDiscription = "Ingredients:\n"
        
        for (index1, index2) in zip(presentedDrink.ingredients.indices, presentedDrink.measure.indices) {
            ingredientsDiscription += "\(presentedDrink.ingredients[index1] ?? Resources.del): \(presentedDrink.measure[index2] ?? Resources.del),\n"
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
