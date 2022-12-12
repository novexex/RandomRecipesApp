//
//  MealEntity.swift
//  testSfera
//
//  Created by Artour Ilyasov on 28.11.2022.
//

import UIKit

struct Meal: Codable {
    var meals: [[String: String?]]
}

final class ParcedMeal: BaseEntity {
    let strMeal: String
    let strArea: String
    
    init(strMeal: String, strArea: String, image: UIImage, category: String, instructions: String) {
        self.strMeal = strMeal
        self.strArea = strArea
        super.init(category: category, instructions: instructions, image: image)
    }
}
