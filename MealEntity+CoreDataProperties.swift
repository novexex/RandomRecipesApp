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
        return NSFetchRequest<MealEntity>(entityName: "MealEntity")
    }

    @NSManaged public var strMeal: String?
    @NSManaged public var strArea: String?
    @NSManaged public var image: String?
    @NSManaged public var category: String?
    @NSManaged public var instructions: String?
    @NSManaged public var ingredients: NSSet?
    @NSManaged public var measure: NSSet?

    public var wrappedCategory: String {
         category ?? ""
     }
     
     public var wrappedImage: String {
         image ?? ""
     }
     
     public var wrappedInstructions: String {
         instructions ?? ""
     }
     
     public var wrappedStrMeal: String {
         strMeal ?? ""
     }
     
     public var wrappedStrArea: String {
         strArea ?? ""
     }
    
    public var wrappedIngredients: [Ingredients] {
        let set = ingredients as? Set<Ingredients> ?? []
        
        return set.sorted {
            $0.wrappedIngredients < $1.wrappedIngredients
        }
    }
    
    public var wrappedMeasure: [Measure] {
        let set = measure as? Set<Measure> ?? []
        
        return set.sorted {
            $0.wrappedMeasure < $1.wrappedMeasure
        }
    }
}

// MARK: Generated accessors for ingredients
extension MealEntity {

    @objc(addIngredientsObject:)
    @NSManaged public func addToIngredients(_ value: Ingredients)

    @objc(removeIngredientsObject:)
    @NSManaged public func removeFromIngredients(_ value: Ingredients)

    @objc(addIngredients:)
    @NSManaged public func addToIngredients(_ values: NSSet)

    @objc(removeIngredients:)
    @NSManaged public func removeFromIngredients(_ values: NSSet)

}

// MARK: Generated accessors for measure
extension MealEntity {

    @objc(addMeasureObject:)
    @NSManaged public func addToMeasure(_ value: Measure)

    @objc(removeMeasureObject:)
    @NSManaged public func removeFromMeasure(_ value: Measure)

    @objc(addMeasure:)
    @NSManaged public func addToMeasure(_ values: NSSet)

    @objc(removeMeasure:)
    @NSManaged public func removeFromMeasure(_ values: NSSet)

}

extension MealEntity : Identifiable {

}
