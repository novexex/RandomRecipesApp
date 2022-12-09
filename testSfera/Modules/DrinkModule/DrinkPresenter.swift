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

    init(interactor: DrinkInteractorProtocol, router: DrinkRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension DrinkPresenter: DrinkPresenterProtocol {
    func buttonSaveTapped() {
        //router.buttonSavePressed()
    }
    
    func viewInput() {
        interactor.loadCocktail()
    }
    
    func viewDidLoaded() {
        interactor.loadCocktail()
    }
    
    func didLoad(drink: Drink) {
        var presentedDrink = ParcedDrink()
        for (key, value) in drink.drinks[0] {
            if let newValue = value { presentedDrink.data.updateValue(newValue, forKey: key) }
        }
        
//        print("\(presentedDrink.data)\n\n\n")
        
        let drinkDiscription = "Drink: \(presentedDrink.data[DictValues.Drink.name] ?? "")\n\n"
        let categoryDiscription = "Category: \(presentedDrink.data[DictValues.category] ?? ""), \(presentedDrink.data[DictValues.Drink.alco] ?? "")\n\n"
        
        var ingredientsDiscription = """
        Ingredients:
        \(presentedDrink.data[DictValues.ingr1] ?? "del"): \(presentedDrink.data[DictValues.meas1] ?? "del"),
        \(presentedDrink.data[DictValues.ingr2] ?? "del"): \(presentedDrink.data[DictValues.meas2] ?? "del"),
        \(presentedDrink.data[DictValues.ingr3] ?? "del"): \(presentedDrink.data[DictValues.meas3] ?? "del"),
        \(presentedDrink.data[DictValues.ingr4] ?? "del"): \(presentedDrink.data[DictValues.meas4] ?? "del"),
        \(presentedDrink.data[DictValues.ingr5] ?? "del"): \(presentedDrink.data[DictValues.meas5] ?? "del"),
        \(presentedDrink.data[DictValues.ingr6] ?? "del"): \(presentedDrink.data[DictValues.meas6] ?? "del"),
        \(presentedDrink.data[DictValues.ingr7] ?? "del"): \(presentedDrink.data[DictValues.meas7] ?? "del"),
        \(presentedDrink.data[DictValues.ingr8] ?? "del"): \(presentedDrink.data[DictValues.meas8] ?? "del"),
        \(presentedDrink.data[DictValues.ingr9] ?? "del"): \(presentedDrink.data[DictValues.meas9] ?? "del"),
        \(presentedDrink.data[DictValues.ingr10] ?? "del"): \(presentedDrink.data[DictValues.meas10] ?? "del"),
        \(presentedDrink.data[DictValues.ingr11] ?? "del"): \(presentedDrink.data[DictValues.meas11] ?? "del"),
        \(presentedDrink.data[DictValues.ingr12] ?? "del"): \(presentedDrink.data[DictValues.meas12] ?? "del"),
        \(presentedDrink.data[DictValues.ingr13] ?? "del"): \(presentedDrink.data[DictValues.meas13] ?? "del"),
        \(presentedDrink.data[DictValues.ingr14] ?? "del"): \(presentedDrink.data[DictValues.meas14] ?? "del"),
        \(presentedDrink.data[DictValues.ingr15] ?? "del"): \(presentedDrink.data[DictValues.meas15] ?? "del"),
        """
        
        let instructionDiscription = "\n\nInstructions:\n\(presentedDrink.data[DictValues.instruct] ?? "")"
        
//        print("\(ingredientsDiscription)\n\n\n")
    
        ingredientsDiscription.formatting()
        
//        print(ingredientsDiscription)

        guard let dictImage = presentedDrink.data[DictValues.Drink.image] else { return }
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
