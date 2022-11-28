//
//  RecipeInteractor.swift
//  testSfera
//
//  Created by Artour Ilyasov on 28.11.2022.
//

import Foundation

protocol RecipeInteractorProtocol: AnyObject {
    
}

class RecipeInteractor: RecipeInteractorProtocol {
    weak var presenter: RecipePresenterProtocol?
}
