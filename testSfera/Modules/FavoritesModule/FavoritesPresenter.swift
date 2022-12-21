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
    
    //should change computed propertys to funcs
    var cellIdentifier: String { get }
    var mealsArrayIsEmpty: Bool { get }
    var drinksArrayIsEmpty: Bool { get }
    var mealsArrayCount: Int { get }
    var drinksArrayCount: Int { get }
}

class FavoritesPresenter {
    weak var view: FavoritesViewProtocol?
    var router: FavoritesRouterProtocol
    var interactor: FavoritesInteractorProtocol
    private var savedMeals = [ParcedMeal]()
    private var savedDrinks = [ParcedDrink]()
    private let identifier = "cell"
    private var viewDidLoaded = false
    
    let storage = StorageManager()
    
    init(interactor: FavoritesInteractorProtocol, router: FavoritesRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension FavoritesPresenter: FavoritesPresenterProtocol {
    func getSectionName(section: Int) -> String {
        let sectionName: String
        switch section {
        case 0:
            sectionName = "Meals"
        case 1:
            sectionName = "Drinks"
        default:
            sectionName = "Default"
        }
        return sectionName
    }
    
    var mealsArrayCount: Int {
        savedMeals.count
    }
    
    var drinksArrayCount: Int {
        savedDrinks.count
    }
    
    var mealsArrayIsEmpty: Bool {
        savedMeals.isEmpty
    }
    
    var drinksArrayIsEmpty: Bool {
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
        indexPath.section == 0 ? router.detailView(recipeEntity: savedMeals[indexPath.row]) : router.detailView(recipeEntity: savedDrinks[indexPath.row])
    }
    
    var cellIdentifier: String {
        identifier
    }
    
    func recipesAddCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        view?.removeWelcomeLabel()
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        guard !savedMeals.isEmpty || !savedDrinks.isEmpty else { return cell }
        if #available(iOS 14.0, *) {
            var content = cell.defaultContentConfiguration()
            content.text = indexPath.section == 0 ? savedMeals[indexPath.row].strMeal : savedDrinks[indexPath.row].strDrink
            cell.contentConfiguration = content
        } else {
            cell.textLabel?.text = indexPath.section == 0 ? savedMeals[indexPath.row].strMeal : savedDrinks[indexPath.row].strDrink
        }
        return cell
    }
    
    func recipesRemoveCell(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if indexPath.section == 0 {
                if tableView.numberOfRows(inSection: 0) == 1 {
                    tableView.deleteSections([0], with: .automatic)
                }
                storage.removeMealContext(rowIndexPath: indexPath.row)
                savedMeals.remove(at: indexPath.row)
                if savedMeals.isEmpty {
                    tableView.reloadData()
                    tableView.deleteSections([indexPath.section], with: .automatic)
                } else {
                    tableView.deleteRows(at: [indexPath], with: .automatic)
                }
            } else {
                storage.removeDrinkContext(rowIndexPath: indexPath.row)
                savedDrinks.remove(at: indexPath.row)
                
                savedDrinks.isEmpty ? tableView.deleteSections(IndexSet(integer: indexPath.section), with: .automatic) : tableView.deleteRows(at: [indexPath], with: .automatic)
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
            if viewDidLoaded {
                savedDrinks.append(drink)
            }
            storage.saveToCoreData(drink: drink)
        } else if let notification = notification.userInfo as? [String: ParcedMeal] {
            guard let meal = notification["meal"] else { return }
            if viewDidLoaded {
                savedMeals.append(meal)
            }
            storage.saveToCoreData(meal: meal)
        }
    }
}
