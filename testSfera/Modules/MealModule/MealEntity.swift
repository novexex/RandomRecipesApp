//
//  MealEntity.swift
//  testSfera
//
//  Created by Artour Ilyasov on 28.11.2022.
//

import UIKit

// MARK: - Meals
struct Meal: Codable {
    var meals: [[String: String?]]
}

struct ParcedMeal {
    var data = [String: String]()
}

final class ParcedMealClass: BaseEntity {
    let strMeal: String
    let strArea: String
    
    init(strMeal: String, strArea: String, image: UIImage, category: String, instructions: String) {
        self.strMeal = strMeal
        self.strArea = strArea
        super.init(category: category, instructions: instructions, image: image)
    }
}
