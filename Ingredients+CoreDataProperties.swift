//
//  Ingredients+CoreDataProperties.swift
//  testSfera
//
//  Created by Artour Ilyasov on 16.12.2022.
//
//

import Foundation
import CoreData


extension Ingredients {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Ingredients> {
        return NSFetchRequest<Ingredients>(entityName: "Ingredients")
    }

    @NSManaged public var ingredients: String?
    @NSManaged public var drinkIngredients: DrinkEntity?
    @NSManaged public var mealIngredients: MealEntity?

}

extension Ingredients : Identifiable {

}
