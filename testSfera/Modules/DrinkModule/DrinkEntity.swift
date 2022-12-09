//
//  DrinkEntity.swift
//  testSfera
//
//  Created by Artour Ilyasov on 28.11.2022.
//

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
    let image: String
    
    init(strDrink: String, strAlcoholic: String, image: String, category: String, instructions: String) {
        self.strDrink = strDrink
        self.strAlcoholic = strAlcoholic
        self.image = image
        super.init(category: category, instructions: instructions)
    }
}
