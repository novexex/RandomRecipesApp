//
//  MealEntity.swift
//  testSfera
//
//  Created by Artour Ilyasov on 28.11.2022.
//

import Foundation

// MARK: - Meals
struct Meal: Codable {
    var meals: [[String: String?]]
}

struct ParcedMeal {
    let strMeal: String
    let strCategory: String
    let strArea: String
    let strYoutube: String
    let strInstructions: String
    let image: String
    let strIngridients: [String?]
    let strMeasure: [String?]
}
