//
//  BaseEntity.swift
//  testSfera
//
//  Created by Artour Ilyasov on 09.12.2022.
//

import UIKit

class BaseEntity {
    let category: String
    let instructions: String
    let image: UIImage
    var ingredients = [String?]()
    var measure = [String?]()
    
    init(category: String, instructions: String, image: UIImage) {
        self.category = category
        self.instructions = instructions
        self.image = image
    }
}
