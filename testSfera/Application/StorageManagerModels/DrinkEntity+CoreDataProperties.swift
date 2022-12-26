//
//  DrinkEntity+CoreDataProperties.swift
//  testSfera
//
//  Created by Artour Ilyasov on 16.12.2022.
//
//

import Foundation
import CoreData


extension DrinkEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DrinkEntity> {
        return NSFetchRequest<DrinkEntity>(entityName: "DrinkEntity")
    }

    @NSManaged public var category: String?
    @NSManaged public var image: String?
    @NSManaged public var instructions: String?
    @NSManaged public var strAlcoholic: String?
    @NSManaged public var strDrink: String?
    @NSManaged public var measure: [String]?
    @NSManaged public var ingredients: [String]?

}

extension DrinkEntity : Identifiable {

}
