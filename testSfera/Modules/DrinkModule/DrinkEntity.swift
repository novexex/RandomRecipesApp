//
//  DrinkEntity.swift
//  testSfera
//
//  Created by Artour Ilyasov on 28.11.2022.
//

import UIKit

struct Drink: Codable {
    var drinks: [[String: String?]]
}

final class ParcedDrink: BaseEntity {
    let strDrink: String
    let strAlcoholic: String
    
    init(strDrink: String, strAlcoholic: String, image: UIImage, category: String, instructions: String) {
        self.strDrink = strDrink
        self.strAlcoholic = strAlcoholic
        super.init(category: category, instructions: instructions, image: image)
    }
}
