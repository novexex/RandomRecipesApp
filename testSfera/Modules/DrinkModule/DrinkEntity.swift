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
