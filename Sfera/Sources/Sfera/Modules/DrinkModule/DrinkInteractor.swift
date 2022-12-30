//
//  DrinkInteractor.swift
//  testSfera
//
//  Created by Artour Ilyasov on 01.12.2022
//

import Foundation

protocol DrinkInteractorProtocol: AnyObject {
    func loadCocktail()
}

class DrinkInteractor {
    weak var presenter: DrinkPresenterProtocol?
    let randomDrinkService = RandomDrinkService()
}

extension DrinkInteractor: DrinkInteractorProtocol {
    func loadCocktail() {
        randomDrinkService.getDate { [weak self] drink in
            self?.presenter?.interactorDidLoad(drink: drink)
        }
    }
}
