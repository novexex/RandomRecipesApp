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
    
    var recipesIsEmpty: Bool { get }
    var recipesCount: Int { get }
    var cellIdentifier: String { get }
    
    var mealsArrayIsEmpty: Bool { get }
    var drinksArrayIsEmpty: Bool { get }
    
    var mealsArrayCount: Int { get }
    var drinksArrayCount: Int { get }
    
    func countSections() -> Int
}

class FavoritesPresenter {
    weak var view: FavoritesViewProtocol?
    var router: FavoritesRouterProtocol
    var interactor: FavoritesInteractorProtocol
    private var savedRecipes = [AnyObject]()
    private var savedMeals = [ParcedMeal]()
    private var savedDrinks = [ParcedDrink]()
    private let identifier = "cell"
    
    let storage = StorageManager()

    init(interactor: FavoritesInteractorProtocol, router: FavoritesRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension FavoritesPresenter: FavoritesPresenterProtocol {
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
        guard !savedRecipes.isEmpty else { return cell }
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
                savedMeals.remove(at: indexPath.row)
            } else {
                savedDrinks.remove(at: indexPath.row)
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        if savedRecipes.isEmpty {
            view?.configureWelcomeLabel()
        }
    }
    
    var recipesCount: Int {
        savedRecipes.count
    }
    
    var recipesIsEmpty: Bool {
        savedRecipes.isEmpty
    }
    
    func routerOutput(vc: DetailCellViewController) {
        view?.presenterOutput(vc: vc)
    }
    
    func routerOutput(notification: Notification) {
        if let notification = notification.userInfo as? [String: ParcedDrink] {
            guard let drink = notification["drink"] else { return }
            savedDrinks.append(drink)
//            storage.saveDrinkToCoreData(drink: drink)
        } else if let notification = notification.userInfo as? [String: ParcedMeal] {
            guard let meal = notification["meal"] else { return }
            savedMeals.append(meal)
//            storage.saveMealToCoreData(meal: meal)
        }
    }
}
