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
    func recipesRemoveCell(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    func recipesAddCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    func viewOutput()
    func getSectionName(section: Int) -> String
    func countSections() -> Int
    func numberOfRowsInSection(section: Int) -> Int
    func mealsArrayIsEmpty() -> Bool
    func drinksArrayIsEmpty() -> Bool
    func mealsArrayCount() -> Int
    func drinksArrayCount() -> Int
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
    private var savedMeals = [ParcedMeal]()
    private var savedDrinks = [ParcedDrink]()
//    private var viewDidLoaded = false
    
    var storage: StorageManager?
    
    init(interactor: FavoritesInteractorProtocol, router: FavoritesRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension FavoritesPresenter: FavoritesPresenterProtocol {
    func numberOfRowsInSection(section: Int) -> Int {
        switch section {
        case Resources.Sections.mealSection:
            guard let mealsSections = storage?.fetchedMealsController?.sections else { return 0 }
            return mealsSections[section].numberOfObjects
        case Resources.Sections.drinkSection:
            guard let drinksSections = storage?.fetchedDrinksController?.sections else { return 0 }
            return drinksSections[section].numberOfObjects
        default:
            return 0
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
            sectionName = Resources.SectionName.empty
        }
        return sectionName
    }
    
    func mealsArrayCount() -> Int {
        savedMeals.count
    }
    
    func drinksArrayCount() -> Int {
        savedDrinks.count
    }
    
    func mealsArrayIsEmpty() -> Bool {
        savedMeals.isEmpty
    }
    
    func drinksArrayIsEmpty() -> Bool {
        savedDrinks.isEmpty
    }
    
    func countSections() -> Int {
        var sections = 0
        if let mealsSections = storage?.fetchedMealsController?.sections {
            if !mealsSections.isEmpty {
                sections += 1
            }
        }
        if let drinksSections = storage?.fetchedDrinksController?.sections {
            if !drinksSections.isEmpty {
                sections += 1
            }
        }
        return sections
    }
    
    func viewOutput() {
        guard let storage else { return }
        storage.setupFetchedDrinksController(for: storage.viewContext)
        storage.setupFetchedMealsController(for: storage.viewContext)
//        viewDidLoaded = true
//        savedMeals += storage.fetchMealData()
//        savedDrinks += storage.fetchDrinkData()
    }
    
    func detailView(didSelectRowAt indexPath: IndexPath) {
//        indexPath.section == 0 ? router.detailView(recipeEntity: savedMeals[indexPath.row]) : router.detailView(recipeEntity: savedDrinks[indexPath.row])
    }
    
    func recipesAddCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        view?.removeWelcomeLabel()
        let cell = tableView.dequeueReusableCell(withIdentifier: Resources.Identifiers.cell, for: indexPath)

        if #available(iOS 14.0, *) {
            var content = cell.defaultContentConfiguration()
            if indexPath.section == Resources.Sections.mealSection {
                guard let meal = storage?.fetchedMealsController?.object(at: indexPath) else { return cell }
                content.text = meal.strMeal ?? ""
            } else if indexPath.section == Resources.Sections.drinkSection {
                guard let drink = storage?.fetchedDrinksController?.object(at: indexPath) else { return cell }
                content.text = drink.strDrink ?? ""
            }
            cell.contentConfiguration = content
        } else {
            if indexPath.section == Resources.Sections.mealSection {
                guard let meal = storage?.fetchedMealsController?.object(at: indexPath) else { return cell }
                cell.textLabel?.text = meal.strMeal ?? ""
            } else if indexPath.section == Resources.Sections.drinkSection {
                guard let drink = storage?.fetchedDrinksController?.object(at: indexPath) else { return cell }
                cell.textLabel?.text = drink.strDrink ?? ""
            }
        }
        
        return cell
    }
    
    func recipesRemoveCell(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if indexPath.section == 0 {
                if savedMeals.count == 1 {
//                    storage?.removeMealContext(rowIndexPath: indexPath.row)
                    savedMeals.remove(at: indexPath.row)
                    
                    tableView.deleteRows(at: [indexPath], with: .automatic)
                    
                    tableView.deleteSections([indexPath.section], with: .automatic)
                } else {
                    tableView.deleteRows(at: [indexPath], with: .automatic)
                }
            } else {
//                storage?.removeDrinkContext(rowIndexPath: indexPath.row)
                savedDrinks.remove(at: indexPath.row)
                
                savedDrinks.isEmpty ? tableView.deleteSections(IndexSet(integer: indexPath.section), with: .automatic) : tableView.deleteRows(at: [indexPath], with: .automatic)
                tableView.reloadData()
            }
        }
        if savedMeals.isEmpty && savedDrinks.isEmpty {
            view?.configureWelcomeLabel()
        }
    }
    
    func routerOutput(vc: DetailCellViewController) {
        view?.presenterOutput(vc: vc)
    }
    
    func routerOutput(notification: Notification) {
        if let notification = notification.userInfo as? [String: ParcedDrink] {
            guard let drink = notification["drink"] else { return }
//            if viewDidLoaded {
//                savedDrinks.append(drink)
//            }
            storage?.saveToCoreData(drink: drink)
        } else if let notification = notification.userInfo as? [String: ParcedMeal] {
            guard let meal = notification["meal"] else { return }
//            if viewDidLoaded {
//                savedMeals.append(meal)
//            }
            storage?.saveToCoreData(meal: meal)
        }
    }
}
