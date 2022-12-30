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
    func viewDidDisappear()
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
    var mealSection = 0
    var drinkSection = 1
    var firstTime = true
    var crash = false
    
    
    init(interactor: FavoritesInteractorProtocol, router: FavoritesRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension FavoritesPresenter: FavoritesPresenterProtocol {
    func viewDidDisappear() {
        guard let storage, let drinksObjects = storage.fetchedDrinksController?.fetchedObjects, let mealsObjects = storage.fetchedMealsController?.fetchedObjects else { return }
        
        if !drinksObjects.isEmpty && mealsObjects.isEmpty {
            Resources.Titles.welcomeLabel = Resources.Titles.crashLabel
            crash = true
            view?.hideTableView()
            view?.configureWelcomeLabel()
        }
    }
    
    func viewDidAppear() {
        guard let storage, let drinksObjects = storage.fetchedDrinksController?.fetchedObjects, let mealsObjects = storage.fetchedMealsController?.fetchedObjects else { return }
        storage.fetchData()
        firstTime = true
        if drinksObjects.isEmpty && mealsObjects.isEmpty {
            mealSection = 0
            drinkSection = 1
        }
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
        case mealSection:
            sectionName = Resources.SectionName.meals
        case drinkSection:
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
        
        if indexPath.section == mealSection {
            router.detailView(recipeEntity: storage.converseEntity(meal: mealsController.object(at: IndexPath(row: 0, section: indexPath.row))))
        } else if indexPath.section == drinkSection {
            router.detailView(recipeEntity: storage.converseEntity(drink: drinksController.object(at: IndexPath(row: 0, section: indexPath.row))))
        }
    }
    
    func recipesAddCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if crash { return UITableViewCell() }
        view?.removeWelcomeLabel()
        let cell = tableView.dequeueReusableCell(withIdentifier: Resources.CellIdentifiers.meal, for: indexPath)
        
        guard let storage, let mealsObjects = storage.fetchedMealsController?.fetchedObjects else { return cell }
        
        if mealsObjects.isEmpty && firstTime {
            let temp = mealSection
            mealSection = drinkSection
            drinkSection = temp
            firstTime = false
        }
        
        if #available(iOS 14.0, *) {
            var content = cell.defaultContentConfiguration()
            if indexPath.section == mealSection {
                guard let meal = storage.fetchedMealsController?.object(at: IndexPath(row: 0, section: indexPath.row)) else { return cell }
                content.text = meal.strMeal ?? Resources.empty
            } else if indexPath.section == drinkSection {
                guard let drink = storage.fetchedDrinksController?.object(at: IndexPath(row: 0, section: indexPath.row)) else { return cell }
                content.text = drink.strDrink ?? Resources.empty
            }
            cell.contentConfiguration = content
        } else {
            if indexPath.section == mealSection {
                guard let meal = storage.fetchedMealsController?.object(at: IndexPath(row: 0, section: indexPath.row)) else { return cell }
                cell.textLabel?.text = meal.strMeal ?? Resources.empty
            } else if indexPath.section == drinkSection {
                guard let drink = storage.fetchedDrinksController?.object(at: IndexPath(row: 0, section: indexPath.row)) else { return cell }
                cell.textLabel?.text = drink.strDrink ?? Resources.empty
            }
        }
        return cell
    }
    
    func recipesActionCell(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if indexPath.section == 0 && mealSection == 0 {
                storage?.remove(indexPath: indexPath, isMeal: true)
            } else {
                storage?.remove(indexPath: indexPath, isMeal: false)
            }
        }
        guard let storage, let drinksFetchedObjects = storage.fetchedDrinksController?.fetchedObjects, let mealsFetchedObjects = storage.fetchedMealsController?.fetchedObjects else { return }
        if drinksFetchedObjects.isEmpty && mealsFetchedObjects.isEmpty {
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
