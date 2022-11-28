//
//  RecipeRouter.swift
//  testSfera
//
//  Created by Artour Ilyasov on 28.11.2022.
//

import Foundation

protocol RecipeRouterProtocol: AnyObject {
    
}

class RecipeRouter: RecipeRouterProtocol {
    weak var presenter: RecipePresenterProtocol?
}
