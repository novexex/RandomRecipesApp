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
    func viewInput() {
        interactor.loadCocktail()
    }
    
    func viewDidLoaded() {
        interactor.loadCocktail()
    }
    
    func didLoad(drink: Drink) {
        let presentedDrink = ParcedDrink(strDrink: drink.drinks[0]["strDrink"]!!,
                                         strCategory: drink.drinks[0]["strCategory"]!!,
                                         strAlcoholic: drink.drinks[0]["strAlcoholic"]!!,
                                         strGlass: drink.drinks[0]["strGlass"]!!,
                                         strInstructions: drink.drinks[0]["strInstructions"]!!,
                                         image: drink.drinks[0]["strDrinkThumb"]!!,
                                         strIngridients: [drink.drinks[0]["strIngredient1"] ?? "",
                                                          drink.drinks[0]["strIngredient2"] ?? "",
                                                          drink.drinks[0]["strIngredient3"] ?? "",
                                                          drink.drinks[0]["strIngredient4"] ?? "",
                                                          drink.drinks[0]["strIngredient5"] ?? "",
                                                          drink.drinks[0]["strIngredient6"] ?? "",
                                                          drink.drinks[0]["strIngredient7"] ?? "",
                                                          drink.drinks[0]["strIngredient8"] ?? "",
                                                          drink.drinks[0]["strIngredient9"] ?? "",
                                                          drink.drinks[0]["strIngredient10"] ?? "",
                                                          drink.drinks[0]["strIngredient11"] ?? "",
                                                          drink.drinks[0]["strIngredient12"] ?? "",
                                                          drink.drinks[0]["strIngredient13"] ?? "",
                                                          drink.drinks[0]["strIngredient14"] ?? "",
                                                          drink.drinks[0]["strIngredient15"] ?? ""],
                                         strMeasure: [drink.drinks[0]["strMeasure1"] ?? "",
                                                      drink.drinks[0]["strMeasure2"] ?? "",
                                                      drink.drinks[0]["strMeasure3"] ?? "",
                                                      drink.drinks[0]["strMeasure4"] ?? "",
                                                      drink.drinks[0]["strMeasure5"] ?? "",
                                                      drink.drinks[0]["strMeasure6"] ?? "",
                                                      drink.drinks[0]["strMeasure7"] ?? "",
                                                      drink.drinks[0]["strMeasure8"] ?? "",
                                                      drink.drinks[0]["strMeasure9"] ?? "",
                                                      drink.drinks[0]["strMeasure10"] ?? "",
                                                      drink.drinks[0]["strMeasure11"] ?? "",
                                                      drink.drinks[0]["strMeasure12"] ?? "",
                                                      drink.drinks[0]["strMeasure13"] ?? "",
                                                      drink.drinks[0]["strMeasure14"] ?? "",
                                                      drink.drinks[0]["strMeasure15"] ?? ""])
        
        let drinkDiscription = "Drink: \(presentedDrink.strDrink)\n\n"
        let categoryDiscription = "Category: \(presentedDrink.strCategory), \(presentedDrink.strAlcoholic)\n\n"
        var ingridientsDiscription = "Ingridients: \(presentedDrink.strIngridients[0] ?? "") \(presentedDrink.strMeasure[0] ?? ""), \(presentedDrink.strIngridients[1] ?? "") \(presentedDrink.strMeasure[1] ?? ""), \(presentedDrink.strIngridients[2] ?? "") \(presentedDrink.strMeasure[2] ?? ""), \(presentedDrink.strIngridients[3] ?? "") \(presentedDrink.strMeasure[3] ?? ""), \(presentedDrink.strIngridients[4] ?? "") \(presentedDrink.strMeasure[4] ?? ""), \(presentedDrink.strIngridients[5] ?? "") \(presentedDrink.strMeasure[5] ?? ""), \(presentedDrink.strIngridients[6] ?? "") \(presentedDrink.strMeasure[6] ?? ""), \(presentedDrink.strIngridients[7] ?? "") \(presentedDrink.strMeasure[7] ?? ""), \(presentedDrink.strIngridients[8] ?? "") \(presentedDrink.strMeasure[8] ?? ""), \(presentedDrink.strIngridients[9] ?? "") \(presentedDrink.strMeasure[9] ?? ""), \(presentedDrink.strIngridients[10] ?? "") \(presentedDrink.strMeasure[10] ?? ""), \(presentedDrink.strIngridients[11] ?? "") \(presentedDrink.strMeasure[11] ?? ""), \(presentedDrink.strIngridients[12] ?? "") \(presentedDrink.strMeasure[12] ?? ""), \(presentedDrink.strIngridients[13] ?? "") \(presentedDrink.strMeasure[13] ?? ""), \(presentedDrink.strIngridients[14] ?? "") \(presentedDrink.strMeasure[14] ?? "")"
        let instructionDiscription = "Instructions: \(presentedDrink.strInstructions)"
        // MARK: rework
        while ingridientsDiscription.last == "\r" || ingridientsDiscription.last == "\n" || ingridientsDiscription.last == " " || ingridientsDiscription.last == "," {
            ingridientsDiscription.removeLast()
        }
        ingridientsDiscription += "\n\n"
        
        let imageURL = URL(string: presentedDrink.image)
        let data = try? Data(contentsOf: imageURL!)
        let image = UIImage(data: data!)!
        view?.viewInput(discription: drinkDiscription + categoryDiscription + ingridientsDiscription + instructionDiscription, image: image)
    }
}
