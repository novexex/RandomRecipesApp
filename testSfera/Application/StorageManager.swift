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
        let container = NSPersistentContainer(name: Resources.persistentContainerName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    var viewContext: NSManagedObjectContext
    var fetchedMealsController: NSFetchedResultsController<MealEntity>?
    var fetchedDrinksController: NSFetchedResultsController<DrinkEntity>?
    let tableView: UITableView
    
    init(tableView: UITableView) {
        self.tableView = tableView
        viewContext = persistentContainer.viewContext
        setupFetchedDrinksController(for: viewContext)
        setupFetchedMealsController(for: viewContext)
        fetchData()
    }

    func fetchData() {
        try? fetchedDrinksController?.performFetch()
        try? fetchedMealsController?.performFetch()
        tableView.reloadData()
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

        saveContext()
    }
    
    func converseEntity(meal: MealEntity) -> ParcedMeal {
        let parcedMeal = ParcedMeal(strMeal: meal.strMeal ?? Resources.empty,
                              strArea: meal.strArea ?? Resources.empty,
                              image: meal.image ?? Resources.empty,
                              category: meal.category ?? Resources.empty,
                              instructions: meal.instructions ?? Resources.empty)
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
        let parcedDrink = ParcedDrink(strDrink: drink.strDrink ?? Resources.empty,
                                      strAlcoholic: drink.strAlcoholic ?? Resources.empty,
                                      image: drink.image ?? Resources.empty,
                                      category: drink.category ?? Resources.empty,
                                      instructions: drink.instructions ?? Resources.empty)
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

    func removeObject(at indexPath: IndexPath) {
        if indexPath.section == Resources.Sections.mealSection {
            guard let fetchedMealsController else { return }
            let managedObject: NSManagedObject = fetchedMealsController.object(at: indexPath) as NSManagedObject
            viewContext.delete(managedObject)
            saveContext()
            fetchData()
        } else if indexPath.section == Resources.Sections.drinkSection {
            guard let fetchedDrinksController else { return }
            let managedObject: NSManagedObject = fetchedDrinksController.object(at: indexPath) as NSManagedObject
            viewContext.delete(managedObject)
            saveContext()
            fetchData()
        }
    }
    
    // MARK: controller funcs didnt call
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        guard let indexPath, let newIndexPath else { return }
        switch type {
        case .update:
            tableView.reloadRows(at: [indexPath], with: .automatic)
        case .delete:
            tableView.deleteRows(at: [indexPath], with: .automatic)
        case .insert:
            tableView.insertRows(at: [newIndexPath], with: .automatic)
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
        let sort = NSSortDescriptor(key: Resources.DictKeys.Meal.name, ascending: true)
        let request = NSFetchRequest<MealEntity>(entityName: Resources.EntityNames.meal)
        request.sortDescriptors = [sort]
        fetchedMealsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedMealsController?.delegate = self
    }
    
    func setupFetchedDrinksController(for context: NSManagedObjectContext) {
        let sort = NSSortDescriptor(key: Resources.DictKeys.Drink.name, ascending: true)
        let request = NSFetchRequest<DrinkEntity>(entityName: Resources.EntityNames.drink)
        request.sortDescriptors = [sort]
        fetchedDrinksController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedDrinksController?.delegate = self
    }
}

// MARK: Trash funcs

extension StorageManager: NSFetchedResultsControllerDelegate {
    func isEqual(_ object: Any?) -> Bool {
        false
    }
    
    var hash: Int {
        0
    }
    
    var superclass: AnyClass? {
        let anyClass: AnyClass? = {
            BaseEntity.self
        }()
        return anyClass
    }
    
    func `self`() -> Self {
        self
    }
    
    func perform(_ aSelector: Selector!) -> Unmanaged<AnyObject>! {
        perform(aSelector)
    }
    
    func perform(_ aSelector: Selector!, with object: Any!) -> Unmanaged<AnyObject>! {
        perform(aSelector, with: object)
    }
    
    func perform(_ aSelector: Selector!, with object1: Any!, with object2: Any!) -> Unmanaged<AnyObject>! {
        perform(aSelector, with: object1, with: object2)
    }
    
    func isProxy() -> Bool {
        false
    }
    
    func isKind(of aClass: AnyClass) -> Bool {
        false
    }
    
    func isMember(of aClass: AnyClass) -> Bool {
        false
    }
    
    func conforms(to aProtocol: Protocol) -> Bool {
        false
    }
    
    func responds(to aSelector: Selector!) -> Bool {
        false
    }
    
    var description: String {
        "description"
    }
}
