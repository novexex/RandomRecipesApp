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
    
    var storage: StorageManager?
    
    init(interactor: FavoritesInteractorProtocol, router: FavoritesRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension FavoritesPresenter: FavoritesPresenterProtocol {
    func viewDidAppear() {
        try? storage?.fetchedMealsController?.performFetch()
        try? storage?.fetchedDrinksController?.performFetch()
        view?.tableView().reloadData()
    }
    
    func countRows(in section: Int) -> Int {
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
        
    func countSections() -> Int {
        var sections = 0
        if let mealsSections = storage?.fetchedMealsController?.fetchedObjects {
            if !mealsSections.isEmpty {
                sections += 1
            }
        }
        if let drinksSections = storage?.fetchedDrinksController?.fetchedObjects {
            if drinksSections.isEmpty {
                sections += 1
            }
        }
        return sections
    }
        
    func detailView(didSelectRowAt indexPath: IndexPath) {
        guard let storage, let drinksController = storage.fetchedDrinksController, let mealsController = storage.fetchedMealsController else { return }
        indexPath.section == Resources.Sections.mealSection ? router.detailView(recipeEntity: storage.converseEntity(meal: mealsController.object(at: indexPath))) : router.detailView(recipeEntity: storage.converseEntity(drink: drinksController.object(at: indexPath)))
    }
    
    func recipesAddCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        view?.removeWelcomeLabel()
        let cell = tableView.dequeueReusableCell(withIdentifier: Resources.cellIdentifier, for: indexPath)
        if #available(iOS 14.0, *) {
            var content = cell.defaultContentConfiguration()
            if indexPath.section == Resources.Sections.mealSection {
                guard let meal = storage?.fetchedMealsController?.object(at: indexPath) else { return cell }
                content.text = meal.strMeal ?? Resources.empty
            } else if indexPath.section == Resources.Sections.drinkSection {
                guard let drink = storage?.fetchedDrinksController?.object(at: indexPath) else { return cell }
                content.text = drink.strDrink ?? Resources.empty
            }
            cell.contentConfiguration = content
        } else {
            if indexPath.section == Resources.Sections.mealSection {
                guard let meal = storage?.fetchedMealsController?.object(at: indexPath) else { return cell }
                cell.textLabel?.text = meal.strMeal ?? Resources.empty
            } else if indexPath.section == Resources.Sections.drinkSection {
                guard let drink = storage?.fetchedDrinksController?.object(at: indexPath) else { return cell }
                cell.textLabel?.text = drink.strDrink ?? Resources.empty
            }
        }
        return cell
    }
    
    func recipesActionCell(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            storage?.removeObject(at: indexPath)
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
