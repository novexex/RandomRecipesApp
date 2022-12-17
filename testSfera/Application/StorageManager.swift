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
        let entityDrink = DrinkEntity(context: viewContext)
        entityDrink.strDrink = drink.strDrink
        entityDrink.strAlcoholic = drink.strAlcoholic
        entityDrink.instructions = drink.instructions
        entityDrink.image = drink.image
        entityDrink.category = drink.category
        
        var ingredients: [String]? = []
        for index in drink.ingredients {
            if let index {
                ingredients?.append(index)
            }
        }
        entityDrink.ingredients = ingredients

        var measure: [String]? = []
        for index in drink.measure {
            if let index {
                measure?.append(index)
            }
        }
        entityDrink.measure = measure
    }
    
    func obtainMeal(meal: ParcedMeal) {
        let entityMeal = MealEntity(context: viewContext)
        entityMeal.strMeal = meal.strMeal
        entityMeal.strArea = meal.strArea
        entityMeal.instructions = meal.instructions
        entityMeal.image = meal.image
        entityMeal.category = meal.category

        var ingredients: [String]? = []
        for index in meal.ingredients {
            if let index {
                ingredients?.append(index)
            }
        }
        entityMeal.ingredients = ingredients

        var measure: [String]? = []
        for index in meal.measure {
            if let index {
                measure?.append(index)
            }
        }
        entityMeal.measure = measure
    }
}

