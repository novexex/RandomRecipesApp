//
//  MealEntity+CoreDataProperties.swift
//  testSfera
//
//  Created by Artour Ilyasov on 16.12.2022.
//
//

import Foundation
import CoreData


extension MealEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MealEntity> {
        return NSFetchRequest<MealEntity>(entityName: Resources.EntityNames.meal)
    }

    @NSManaged public var category: String?
    @NSManaged public var image: String?
    @NSManaged public var instructions: String?
    @NSManaged public var strArea: String?
    @NSManaged public var strMeal: String?
    @NSManaged public var ingredients: [String]?
    @NSManaged public var measure: [String]?

}

extension MealEntity : Identifiable {

}
