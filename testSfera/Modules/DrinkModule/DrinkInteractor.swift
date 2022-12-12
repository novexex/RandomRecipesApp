//
//  DrinkInteractor.swift
//  testSfera
//
//  Created by Artour Ilyasov on 01.12.2022
//

import Foundation

protocol DrinkInteractorProtocol: AnyObject {
    func loadCocktail()
    func buttonSavePressed()
}

class DrinkInteractor: DrinkInteractorProtocol {
    func buttonSavePressed() {
        if presenter?.countOfSaveButtonPress != 1 {
            presenter?.showAlert()
        } else {
            presenter?.callRouter()
        }
    }
    
    func checkForRepeat() {
        
    }
    
    weak var presenter: DrinkPresenterProtocol?
    
    let randomDrinkService = RandomDrinkService()
    
    func loadCocktail() {
        randomDrinkService.getDate { [weak self] drink in
            self?.presenter?.didLoad(drink: drink)
        }
        presenter?.countOfSaveButtonPress = 0
    }
}

