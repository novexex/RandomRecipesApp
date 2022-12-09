//
//  MealEntity.swift
//  testSfera
//
//  Created by Artour Ilyasov on 28.11.2022.
//

// MARK: - Meals
struct Meal: Codable {
    var meals: [[String: String?]]
}

struct ParcedMeal {
    var data = [String: String]()
}

