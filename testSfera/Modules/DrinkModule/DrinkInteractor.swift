//
//  DrinkInteractor.swift
//  Super easy dev
//
//  Created by Artour Ilyasov on 01.12.2022
//

import Foundation

protocol DrinkInteractorProtocol: AnyObject {
    func loadCocktail()
}

class DrinkInteractor: DrinkInteractorProtocol {
    weak var presenter: DrinkPresenterProtocol?
    
    let randomDrinkService = RandomDrinkService()
    
    func loadCocktail() {
        randomDrinkService.getDate { [weak self] drink in
            self?.presenter?.didLoad(drink: drink)
        }
    }
}
