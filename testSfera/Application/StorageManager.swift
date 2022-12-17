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
    
    func saveDrinkToCoreData(drink: ParcedDrink) {
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
        
        do {
            try viewContext.save()
            print("Drink Saved Successfully")
        } catch {
            print("Drink Save Error: \(error.localizedDescription)")
        }
    }
    
    func saveMealToCoreData(meal: ParcedMeal) {
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
        
        do {
            try viewContext.save()
            print("Meal Saved Successfully")
        } catch {
            print("Meal Save Error: \(error.localizedDescription)")
        }
    }
    
    func fetchMealData() -> [ParcedMeal] {
        var entityMealArray = [MealEntity]()
        var parcedMealArray = [ParcedMeal]()
        let fetchRequest = MealEntity.fetchRequest()
        do {
            entityMealArray = try viewContext.fetch(fetchRequest)
            for (index, _) in entityMealArray.enumerated() {
                parcedMealArray.append(converseEntity(meal: entityMealArray[index]))
            }
        } catch {
            print("FetchData Error: \(error.localizedDescription)")
        }
        
        return parcedMealArray
    }
    
    func fetchDrinkData() -> [ParcedDrink] {
        var entityDrinkArray = [DrinkEntity]()
        var parcedDrinkArray = [ParcedDrink]()
        let fetchRequest = DrinkEntity.fetchRequest()
        do {
            entityDrinkArray = try viewContext.fetch(fetchRequest)
            for (index, _) in entityDrinkArray.enumerated() {
                parcedDrinkArray.append(converseEntity(drink: entityDrinkArray[index]))
            }
        } catch {
            print("FetchData Error: \(error.localizedDescription)")
        }
        
        return parcedDrinkArray
    }
    
    func converseEntity(meal: MealEntity) -> ParcedMeal {
        let parcedMeal = ParcedMeal(strMeal: meal.strMeal ?? "",
                              strArea: meal.strArea ?? "",
                              image: meal.image ?? "",
                              category: meal.category ?? "",
                              instructions: meal.instructions ?? "")
        if let ingr = meal.ingredients {
            for index in ingr {
                parcedMeal.ingredients.append(index)
            }
        }
        
        if let measure = meal.measure {
            for index in measure {
                parcedMeal.measure.append(index)
            }
        }
        
        return parcedMeal
    }
    
    func converseEntity(drink: DrinkEntity) -> ParcedDrink {
        let parcedDrink = ParcedDrink(strDrink: drink.strDrink ?? "",
                                      strAlcoholic: drink.strAlcoholic ?? "",
                                      image: drink.image ?? "",
                                      category: drink.category ?? "",
                                      instructions: drink.instructions ?? "")
        if let ingr = drink.ingredients {
            for index in ingr {
                parcedDrink.ingredients.append(index)
            }
        }
        
        if let measure = drink.measure {
            for index in measure {
                parcedDrink.measure.append(index)
            }
        }
        
        return parcedDrink
    }
}
