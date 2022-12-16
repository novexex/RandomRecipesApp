//
//  Measure+CoreDataProperties.swift
//  testSfera
//
//  Created by Artour Ilyasov on 16.12.2022.
//
//

import Foundation
import CoreData


extension Measure {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Measure> {
        return NSFetchRequest<Measure>(entityName: "Measure")
    }

    @NSManaged public var measure: String?
    @NSManaged public var drinkMeasure: DrinkEntity?
    @NSManaged public var mealMeasure: MealEntity?

    public var wrappedMeasure: String {
        measure ?? ""
    }
    
}

extension Measure : Identifiable {

}
