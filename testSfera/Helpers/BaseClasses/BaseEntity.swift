//
//  BaseEntity.swift
//  testSfera
//
//  Created by Artour Ilyasov on 09.12.2022.
//

class BaseEntity {
    let category: String
    let instructions: String
    var ingredients = [String?]()
    var measure = [String?]()
    
    init(category: String, instructions: String) {
        self.category = category
        self.instructions = instructions
    }
}
