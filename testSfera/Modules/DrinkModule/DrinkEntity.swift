//
//  RandomCoctailClass.swift
//  testSfera
//
//  Created by Artour Ilyasov on 28.11.2022.
//

import Foundation

// MARK: - Drinks
struct Drink: Codable {
    var drinks: [[String: String?]]
}

struct ParcedDrink {
    let strDrink: String
    let strCategory: String
    let strAlcoholic: String
    let strGlass: String
    let strInstructions: String
    let image: String
    let strIngridients: [String?]
    let strMeasure: [String?]
}
