//
//  FavoritesPresenter.swift
//  testSfera
//
//  Created by Artour Ilyasov on 01.12.2022
//

import Foundation
import UIKit

protocol FavoritesPresenterProtocol: AnyObject {
    func detailView(didSelectRowAt indexPath: IndexPath)
    func routerOutput(notification: Notification)
    func routerOutput(vc: DetailCellViewController)
    func recipesActionCell(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    func recipesAddCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    func getSectionName(section: Int) -> String
    func countSections() -> Int
    func countRows(in section: Int) -> Int
    func viewDidAppear()
    func removeStorage(indexPath: IndexPath)
}

class FavoritesPresenter {
    weak var view: FavoritesViewProtocol? {
        didSet {
            guard let view else { return }
            storage = StorageManager(tableView: view.tableView())
        }
    }
    var router: FavoritesRouterProtocol
    var interactor: FavoritesInteractorProtocol
    var storage: StorageManager?
    
    init(interactor: FavoritesInteractorProtocol, router: FavoritesRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension FavoritesPresenter: FavoritesPresenterProtocol {
    func removeStorage(indexPath: IndexPath) {
        storage?.removeObject(at: indexPath)
    }
    
    func viewDidAppear() {
        storage?.fetchData()
    }
    
    func countRows(in section: Int) -> Int {
        guard let storage, let drinksController = storage.fetchedDrinksController, let drinksObjects = drinksController.fetchedObjects, let mealsController = storage.fetchedMealsController, let mealsObjects = mealsController.fetchedObjects else { return 0 }
        if drinksObjects.isEmpty || mealsObjects.isEmpty {
            if drinksObjects.isEmpty {
                return mealsObjects.count
            } else if mealsObjects.isEmpty {
                return drinksObjects.count
            }
            return 0
        } else {
            switch section {
            case Resources.Sections.mealSection:
                return mealsObjects.count
            case Resources.Sections.drinkSection:
                return drinksObjects.count
            default:
                return 0
            }
        }
    }
    
    func getSectionName(section: Int) -> String {
        let sectionName: String
        switch section {
        case Resources.Sections.mealSection:
            sectionName = Resources.SectionName.meals
        case Resources.Sections.drinkSection:
            sectionName = Resources.SectionName.drinks
        default:
            sectionName = Resources.empty
        }
        return sectionName
    }
        
    func countSections() -> Int {
        var sections = 0
        if let mealsSections = storage?.fetchedMealsController?.fetchedObjects {
            if !mealsSections.isEmpty {
                sections += 1
            }
        }
        if let drinksSections = storage?.fetchedDrinksController?.fetchedObjects {
            if !drinksSections.isEmpty {
                sections += 1
            }
        }
        return sections
    }
        
    func detailView(didSelectRowAt indexPath: IndexPath) {
        guard let storage, let drinksController = storage.fetchedDrinksController, let mealsController = storage.fetchedMealsController else { return }
        indexPath.section == Resources.Sections.mealSection ? router.detailView(recipeEntity: storage.converseEntity(meal: mealsController.object(at: IndexPath(row: 0, section: indexPath.row)))) : router.detailView(recipeEntity: storage.converseEntity(drink: drinksController.object(at: IndexPath(row: 0, section: indexPath.row))))
    }
    
    func recipesAddCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let storage, let drinksController = storage.fetchedDrinksController, let drinksObjects = drinksController.fetchedObjects, let mealsController = storage.fetchedMealsController, let mealsObjects = mealsController.fetchedObjects else { return UITableViewCell() }
//        if drinksObjects.isEmpty || mealsObjects.isEmpty {
//            if drinksObjects.isEmpty {
//
//            } else if mealsObjects.isEmpty {
//
//            }
//        }
        view?.removeWelcomeLabel()
        let cell = tableView.dequeueReusableCell(withIdentifier: Resources.CellIdentifiers.meal, for: indexPath)
        // MARK: проблема в indexPath, костыли работают, но сложно сделать костыль для добавления ячеек
//                guard let storage, let drinksController = storage.fetchedDrinksController, let drinksObjects = drinksController.fetchedObjects, let mealsController = storage.fetchedMealsController, let mealsObjects = mealsController.fetchedObjects else { return cell }
        if #available(iOS 14.0, *) {
            var content = cell.defaultContentConfiguration()
//            if mealsObjects.isEmpty {
//                guard let drink = storage.fetchedDrinksController?.object(at: IndexPath(row: 0, section: indexPath.row)) else { return cell }
//                content.text = drink.strDrink ?? Resources.empty
//            }
            if indexPath.section == Resources.Sections.mealSection {
                guard let meal = storage?.fetchedMealsController?.object(at: IndexPath(row: 0, section: indexPath.row)) else { return cell }
                content.text = meal.strMeal ?? Resources.empty
            } else if indexPath.section == Resources.Sections.drinkSection {
                guard let drink = storage?.fetchedDrinksController?.object(at: IndexPath(row: 0, section: indexPath.row)) else { return cell }
                content.text = drink.strDrink ?? Resources.empty
            }
            cell.contentConfiguration = content
        } else {
            if indexPath.section == Resources.Sections.mealSection {
                guard let meal = storage?.fetchedMealsController?.object(at: IndexPath(row: 0, section: indexPath.row)) else { return cell }
                cell.textLabel?.text = meal.strMeal ?? Resources.empty
            } else if indexPath.section == Resources.Sections.drinkSection {
                guard let drink = storage?.fetchedDrinksController?.object(at: IndexPath(row: 0, section: indexPath.row)) else { return cell }
                cell.textLabel?.text = drink.strDrink ?? Resources.empty
            }
        }
//        storage?.fetchData()
        return cell
    }
    
    func recipesActionCell(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
//            guard let storage, let qwe = storage.fetchedMealsController, let asd = qwe.fetchedObjects else { return }
//            for i in asd {
//                print("meals indexPath row: \(String(describing: qwe.indexPath(forObject: i)?.row))")
//                print("meals indexPath section: \(String(describing: qwe.indexPath(forObject: i)?.section))")
//            }
//
//            print("---------------------------")
//
//            guard let qwe = storage.fetchedDrinksController, let asd = qwe.fetchedObjects else { return }
//            for i in asd {
//                print("drinks indexPath row: \(String(describing: qwe.indexPath(forObject: i)?.row))")
//                print("drinks indexPath section: \(String(describing: qwe.indexPath(forObject: i)?.section))")
//            }
//            if indexPath.section == 0 {
//                storage?.remove(indexPath: indexPath, isMeal: true)
//            } else {
//                storage?.remove(indexPath: indexPath, isMeal: false)
//            }
//            storage?.remove(indexPath: indexPath, isMeal: <#T##Bool#>)
            storage?.removeObject(at: indexPath)
//            storage.

        }
        guard let storage, let drinksFetchedObjs = storage.fetchedDrinksController?.fetchedObjects, let mealsFetchedObjs = storage.fetchedMealsController?.fetchedObjects else { return }
        if drinksFetchedObjs.isEmpty && mealsFetchedObjs.isEmpty {
            view?.configureWelcomeLabel()
        }
    }
    
    func routerOutput(vc: DetailCellViewController) {
        view?.presenterOutput(vc: vc)
    }
    
    func routerOutput(notification: Notification) {
        
        if let notification = notification.userInfo as? [String: ParcedDrink] {
            guard let drink = notification[Resources.DictKeys.drink] else { return }
            storage?.saveToCoreData(drink: drink)
        } else if let notification = notification.userInfo as? [String: ParcedMeal] {
            guard let meal = notification[Resources.DictKeys.meal] else { return }
            storage?.saveToCoreData(meal: meal)
        }
    }
}
