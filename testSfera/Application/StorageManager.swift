//
//  StorageManager.swift
//  testSfera
//
//  Created by Artour Ilyasov on 12.12.2022.
//

import CoreData

class StorageManager {
    private var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    private lazy var viewContext: NSManagedObjectContext = persistentContainer.viewContext
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func obtainDrink(drink: ParcedDrink) {
//        let entityDrink = DrinkEntity(context: viewContext)
//        entityDrink.strDrink = drink.strDrink
//        entityDrink.strAlcoholic = drink.strAlcoholic
//        entityDrink.instructions = drink.instructions
//        entityDrink.image = drink.image
//        entityDrink.category = drink.category
//
//        for index in drink.ingredients {
//            if let index {
//                entityDrink.drinkIngredients?.setValue(index, forKey: <#T##String#>)
//            } else {
//                break
//            }
//        }
//
//        for index in drink.measure {
//            if let index {
//                entityDrink.drinkMeasure?.setValue(index, forKey: <#T##String#>)
//            } else {
//                break
//            }
//
//            print(entityDrink)
//        }
    }
    
    func obtainMeal(meal: ParcedMeal) {
//        let entityMeal = MealEntity(context: viewContext)
//        entityMeal.strMeal = meal.strMeal
//        entityMeal.strArea = meal.strArea
//        entityMeal.instructions = meal.instructions
//        entityMeal.image = meal.image
//        entityMeal.category = meal.category
//
//        for index in meal.ingredients {
//            if let index {
//                print(index)
//                entityMeal.ingredients?.append(index)
//            } else {
//                break
//            }
//        }
//
//        for index in meal.measure {
//            if let index {
//                entityMeal.measure?.append(index)
//            } else {
//                break
//            }
//        }
//
//        print(entityMeal)
    }
}

