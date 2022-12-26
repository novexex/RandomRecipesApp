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
    func countRows(section: Int) -> Int
    func mealsArrayIsEmpty() -> Bool
    func drinksArrayIsEmpty() -> Bool
    func mealsArrayCount() -> Int
    func drinksArrayCount() -> Int
}

class FavoritesPresenter {
    weak var view: FavoritesViewProtocol?
    var router: FavoritesRouterProtocol
    var interactor: FavoritesInteractorProtocol
    private var savedMeals = [ParcedMeal]()
    private var savedDrinks = [ParcedDrink]()
    private var viewDidLoaded = false
    
    let storage = StorageManager()
    
    init(interactor: FavoritesInteractorProtocol, router: FavoritesRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    func removeEntity(rowIndexPath: Int) {
        storage.removeMealContext(rowIndexPath: rowIndexPath)
        savedMeals.remove(at: rowIndexPath)
    }
}

extension FavoritesPresenter: FavoritesPresenterProtocol {
    func countRows(section: Int) -> Int {
        if section == Resources.Section.mealSection {
            return mealsArrayCount()
        } else if section == Resources.Section.drinkSection {
            return drinksArrayCount()
        }
        return 0
    }
    
    func getSectionName(section: Int) -> String {
        let sectionName: String
        switch section {
        case Resources.Section.mealSection:
            sectionName = Resources.SectionNames.meals
        case Resources.Section.drinkSection:
            sectionName = Resources.SectionNames.drinks
        default:
            sectionName = Resources.empty
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
         if !savedMeals.isEmpty && !savedDrinks.isEmpty {
            return 2
        } else if !savedMeals.isEmpty || !savedDrinks.isEmpty {
            return 1
        } else {
            return 0
        }
    }
    
    func viewOutput() {
        viewDidLoaded = true
        savedMeals += storage.fetchMealData()
        savedDrinks += storage.fetchDrinkData()
    }
    
    func detailView(didSelectRowAt indexPath: IndexPath) {
        indexPath.section == Resources.Section.mealSection ? router.detailView(recipeEntity: savedMeals[indexPath.row]) : router.detailView(recipeEntity: savedDrinks[indexPath.row])
    }

    func recipesAddCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        view?.removeWelcomeLabel()
        let cell = tableView.dequeueReusableCell(withIdentifier: Resources.cellIdentifier, for: indexPath)
        guard !savedMeals.isEmpty || !savedDrinks.isEmpty else { return cell }
        if #available(iOS 14.0, *) {
            var content = cell.defaultContentConfiguration()
            content.text = indexPath.section == Resources.Section.mealSection ? savedMeals[indexPath.row].strMeal : savedDrinks[indexPath.row].strDrink
            cell.contentConfiguration = content
        } else {
            cell.textLabel?.text = indexPath.section == Resources.Section.mealSection ? savedMeals[indexPath.row].strMeal : savedDrinks[indexPath.row].strDrink
        }
        return cell
    }
    
    func recipesRemoveCell(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if indexPath.section == Resources.Section.mealSection {
//                if tableView.numberOfRows(inSection: 0) == 1 {
//                    if tableView.numberOfSections == 2 {
//                        removeEntity(rowIndexPath: indexPath.row)
//                        tableView.reloadRows(at: [indexPath], with: .automatic)
//                        tableView.deleteRows(at: [indexPath], with: .automatic)
//                    }
//                    tableView.deleteSections([indexPath.section], with: .automatic)
//                } else {
//                    tableView.deleteRows(at: [indexPath], with: .automatic)
//                }
                removeEntity(rowIndexPath: indexPath.row)
                
                savedMeals.isEmpty ? tableView.deleteSections([indexPath.section], with: .automatic) : tableView.deleteRows(at: [indexPath], with: .automatic)
            } else if indexPath.section == Resources.Section.drinkSection {
                removeEntity(rowIndexPath: indexPath.row)
                savedDrinks.isEmpty ? tableView.deleteSections([indexPath.section], with: .automatic) : tableView.deleteRows(at: [indexPath], with: .automatic)
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
            guard let drink = notification[Resources.DictKeys.drink] else { return }
            if viewDidLoaded {
                savedDrinks.append(drink)
            }
            storage.saveToCoreData(drink: drink)
        } else if let notification = notification.userInfo as? [String: ParcedMeal] {
            guard let meal = notification[Resources.DictKeys.meal] else { return }
            if viewDidLoaded {
                savedMeals.append(meal)
            }
            storage.saveToCoreData(meal: meal)
        }
    }
}
