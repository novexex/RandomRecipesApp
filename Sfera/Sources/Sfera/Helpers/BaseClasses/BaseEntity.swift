//
//  BaseEntity.swift
//  testSfera
//
//  Created by Artour Ilyasov on 09.12.2022.
//

class BaseEntity {
    let category: String
    let instructions: String
    let image: String
    var ingredients = [String?]()
    var measure = [String?]()
    
    init(category: String, instructions: String, image: String) {
        self.category = category
        self.instructions = instructions
        self.image = image
    }
}
