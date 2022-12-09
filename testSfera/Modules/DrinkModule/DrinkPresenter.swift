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
    func viewInput()
    func buttonSaveTapped()
}

class DrinkPresenter {
    weak var view: DrinkViewProtocol?
    var router: DrinkRouterProtocol
    var interactor: DrinkInteractorProtocol
    var lastLoadedDrink: ParcedDrinkClass?
    
    init(interactor: DrinkInteractorProtocol, router: DrinkRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension DrinkPresenter: DrinkPresenterProtocol {
    func buttonSaveTapped() {
        guard let lastLoadedDrink else { return }
        router.buttonSavePressed(drink: lastLoadedDrink)
    }
    
    func viewInput() {
        interactor.loadCocktail()
    }
    
    func viewDidLoaded() {
        interactor.loadCocktail()
    }
    
    func didLoad(drink: Drink) {
        let presentedDrink = ParcedDrinkClass(strDrink: (drink.drinks[0][DictKeys.Drink.name] ?? "") ?? "",
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
        let instructionDiscription = "\n\nInstructions:\n\(presentedDrink.instructions)"
        var ingredientsDiscription = ""
        
        for (index, _) in presentedDrink.ingredients.enumerated() {
            ingredientsDiscription += "\(presentedDrink.ingredients[index] ?? "del"): \(presentedDrink.measure[index] ?? "del"),\n"
        }

        ingredientsDiscription.formatting()

        let urlImage = URL(string: presentedDrink.image)
        
        guard let urlImage else { return }
        let data = try? Data(contentsOf: urlImage)
        
        guard let data else { return }
        let image = UIImage(data: data)
        
        guard let image else { return }
        view?.viewInput(discription: drinkDiscription + categoryDiscription + ingredientsDiscription + instructionDiscription,
                        image: image)
        
        
            // MARK: Dictionary style
            /*
             var presentedDrink = ParcedDrink()
             for (key, value) in drink.drinks[0] {
             if let newValue = value { presentedDrink.data.updateValue(newValue, forKey: key) }
             }
             
             lastLoadedDrink = presentedDrink
             //        print("\(presentedDrink.data)\n\n\n")
             
             
             let drinkDiscription = "Drink: \(presentedDrink.data[DictKeys.Drink.name] ?? "")\n\n"
             let categoryDiscription = "Category: \(presentedDrink.data[DictKeys.category] ?? ""), \(presentedDrink.data[DictKeys.Drink.alco] ?? "")\n\n"
             
             var ingredientsDiscription = """
             Ingredients:
             \(presentedDrink.data[DictKeys.ingr1] ?? "del"): \(presentedDrink.data[DictKeys.meas1] ?? "del"),
             \(presentedDrink.data[DictKeys.ingr2] ?? "del"): \(presentedDrink.data[DictKeys.meas2] ?? "del"),
             \(presentedDrink.data[DictKeys.ingr3] ?? "del"): \(presentedDrink.data[DictKeys.meas3] ?? "del"),
             \(presentedDrink.data[DictKeys.ingr4] ?? "del"): \(presentedDrink.data[DictKeys.meas4] ?? "del"),
             \(presentedDrink.data[DictKeys.ingr5] ?? "del"): \(presentedDrink.data[DictKeys.meas5] ?? "del"),
             \(presentedDrink.data[DictKeys.ingr6] ?? "del"): \(presentedDrink.data[DictKeys.meas6] ?? "del"),
             \(presentedDrink.data[DictKeys.ingr7] ?? "del"): \(presentedDrink.data[DictKeys.meas7] ?? "del"),
             \(presentedDrink.data[DictKeys.ingr8] ?? "del"): \(presentedDrink.data[DictKeys.meas8] ?? "del"),
             \(presentedDrink.data[DictKeys.ingr9] ?? "del"): \(presentedDrink.data[DictKeys.meas9] ?? "del"),
             \(presentedDrink.data[DictKeys.ingr10] ?? "del"): \(presentedDrink.data[DictKeys.meas10] ?? "del"),
             \(presentedDrink.data[DictKeys.ingr11] ?? "del"): \(presentedDrink.data[DictKeys.meas11] ?? "del"),
             \(presentedDrink.data[DictKeys.ingr12] ?? "del"): \(presentedDrink.data[DictKeys.meas12] ?? "del"),
             \(presentedDrink.data[DictKeys.ingr13] ?? "del"): \(presentedDrink.data[DictKeys.meas13] ?? "del"),
             \(presentedDrink.data[DictKeys.ingr14] ?? "del"): \(presentedDrink.data[DictKeys.meas14] ?? "del"),
             \(presentedDrink.data[DictKeys.ingr15] ?? "del"): \(presentedDrink.data[DictKeys.meas15] ?? "del"),
             """
             
             let instructionDiscription = "\n\nInstructions:\n\(presentedDrink.data[DictKeys.instruct] ?? "")"
             
             //        print("\(ingredientsDiscription)\n\n\n")
             
             ingredientsDiscription.formatting()
             
             //        print(ingredientsDiscription)
             
             guard let dictImage = presentedDrink.data[DictKeys.Drink.image] else { return }
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
