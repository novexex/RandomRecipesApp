//
//  DrinkEntity.swift
//  testSfera
//
//  Created by Artour Ilyasov on 28.11.2022.
//

import UIKit

// MARK: - Drinks

struct Drink: Codable {
    var drinks: [[String: String?]]
}

struct ParcedDrink {
    var data = [String: String]()
}

final class ParcedDrinkClass: BaseEntity {
    let strDrink: String
    let strAlcoholic: String
    
    init(strDrink: String, strAlcoholic: String, image: UIImage, category: String, instructions: String) {
        self.strDrink = strDrink
        self.strAlcoholic = strAlcoholic
        super.init(category: category, instructions: instructions, image: image)
    }
    
    static func ==(lhs: ParcedDrinkClass, rhs: ParcedDrinkClass) -> Bool {
        var returnValue = true
        if lhs.strDrink != rhs.strDrink {
            returnValue = false
        } else if lhs.category != rhs.category {
            returnValue = false
        } else if lhs.image != rhs.image {
            returnValue = false
        } else if lhs.strAlcoholic != rhs.strAlcoholic {
            returnValue = false
        } else if lhs.measure != rhs.measure {
            returnValue = false
        } else if lhs.instructions != rhs.instructions {
            returnValue = false
        } else if lhs.ingredients != rhs.ingredients {
            returnValue = false
        }
        return returnValue
    }
}
