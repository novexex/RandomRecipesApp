//
//  StorageManager.swift
//  testSfera
//
//  Created by Artour Ilyasov on 12.12.2022.
//

import CoreData
import UIKit

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
    private var savedEntityMealsArray = [MealEntity]()
    private var savedEntityDrinksArray = [DrinkEntity]()
    var fetchedMealsController: NSFetchedResultsController<MealEntity>?
    var fetchedDrinksController: NSFetchedResultsController<DrinkEntity>?
    let tableView: UITableView
    
    init(tableView: UITableView) {
        self.tableView = tableView
    }

    func saveContext() {
        if persistentContainer.viewContext.hasChanges {
            do {
                try persistentContainer.viewContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func removeMealContext(rowIndexPath: Int) {
        persistentContainer.viewContext.delete(savedEntityMealsArray[rowIndexPath])
        savedEntityMealsArray.remove(at: rowIndexPath)
        saveContext()
    }
    
    func removeDrinkContext(rowIndexPath: Int) {
        persistentContainer.viewContext.delete(savedEntityDrinksArray[rowIndexPath])
        savedEntityDrinksArray.remove(at: rowIndexPath)
        saveContext()
    }
        
    func saveToCoreData(drink: ParcedDrink) {
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
        
        savedEntityDrinksArray.append(entityDrink)
        
        saveContext()
    }
    
    func saveToCoreData(meal: ParcedMeal) {
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
        
        savedEntityMealsArray.append(entityMeal)
        
        saveContext()
    }
    
    func fetchMealData() -> [ParcedMeal] {
        var entityMealsArray = [MealEntity]()
        var parcedMealsArray = [ParcedMeal]()
        let fetchRequest = MealEntity.fetchRequest()
        do {
            entityMealsArray = try viewContext.fetch(fetchRequest)
            for (index, _) in entityMealsArray.enumerated() {
                parcedMealsArray.append(converseEntity(meal: entityMealsArray[index]))
            }
        } catch {
            print("Fetch Meal Data Error: \(error.localizedDescription)")
        }
        
        savedEntityMealsArray = entityMealsArray
        
        
        return parcedMealsArray
    }
    
    func fetchDrinkData() -> [ParcedDrink] {
        var entityDrinksArray = [DrinkEntity]()
        var parcedDrinksArray = [ParcedDrink]()
        let fetchRequest = DrinkEntity.fetchRequest()
        do {
            entityDrinksArray = try viewContext.fetch(fetchRequest)
            for (index, _) in entityDrinksArray.enumerated() {
                parcedDrinksArray.append(converseEntity(drink: entityDrinksArray[index]))
            }
        } catch {
            print("Fetch Drink Data Error: \(error.localizedDescription)")
        }
        
        savedEntityDrinksArray = entityDrinksArray
        
        return parcedDrinksArray
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

extension StorageManager: NSFetchedResultsControllerDelegate {
    func isEqual(_ object: Any?) -> Bool {
        false
    }
    
    var hash: Int {
        0
    }
    
    var superclass: AnyClass? {
        <#code#>
    }
    
    func `self`() -> Self {
        <#code#>
    }
    
    func perform(_ aSelector: Selector!) -> Unmanaged<AnyObject>! {
        <#code#>
    }
    
    func perform(_ aSelector: Selector!, with object: Any!) -> Unmanaged<AnyObject>! {
        <#code#>
    }
    
    func perform(_ aSelector: Selector!, with object1: Any!, with object2: Any!) -> Unmanaged<AnyObject>! {
        <#code#>
    }
    
    func isProxy() -> Bool {
        <#code#>
    }
    
    func isKind(of aClass: AnyClass) -> Bool {
        <#code#>
    }
    
    func isMember(of aClass: AnyClass) -> Bool {
        <#code#>
    }
    
    func conforms(to aProtocol: Protocol) -> Bool {
        <#code#>
    }
    
    func responds(to aSelector: Selector!) -> Bool {
        <#code#>
    }
    
    var description: String {
        <#code#>
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        guard let newIndexPath, let indexPath else { return }
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        case .update:
            tableView.reloadRows(at: [indexPath], with: .automatic)
        case .move:
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        case .delete:
            tableView.deleteRows(at: [indexPath], with: .automatic)
        default:
            return
        }
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func setupFetchedMealsController(for context: NSManagedObjectContext) {
        let request = NSFetchRequest<MealEntity>(entityName: "MealEntity")
        
        fetchedMealsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedMealsController?.delegate = self
    }
}
