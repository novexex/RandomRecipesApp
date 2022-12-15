//
//  FavoritesPresenter.swift
//  testSfera
//
//  Created by Artour Ilyasov on 01.12.2022
//

import Foundation
import UIKit

protocol FavoritesPresenterProtocol: AnyObject {
    func detailView(didSelectRowAt indexPathRow: Int)
    func routerOutput(notification: Notification)
    func routerOutput(vc: DetailCellViewController)
    func recipesRemoveCell(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    func recipesAddCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    
    var recipesIsEmpty: Bool { get }
    var recipesCount: Int { get }
    var cellIdentifier: String { get }
}

class FavoritesPresenter {
    weak var view: FavoritesViewProtocol?
    var router: FavoritesRouterProtocol
    var interactor: FavoritesInteractorProtocol
    private var savedRecipes = [AnyObject]()
    private let identifier = "cell"

    init(interactor: FavoritesInteractorProtocol, router: FavoritesRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension FavoritesPresenter: FavoritesPresenterProtocol {
    func detailView(didSelectRowAt indexPathRow: Int) {
        router.detailView(recipeEntity: savedRecipes[indexPathRow])
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
            if let meal = savedRecipes[indexPath.row] as? ParcedMeal {
                content.text = meal.strMeal
            } else if let drink = savedRecipes[indexPath.row] as? ParcedDrink {
                content.text = drink.strDrink
            }
            cell.contentConfiguration = content
        } else {
            if let meal = savedRecipes[indexPath.row] as? ParcedMeal {
                cell.textLabel?.text = meal.strMeal
            } else if let drink = savedRecipes[indexPath.row] as? ParcedDrink {
                cell.textLabel?.text = drink.strDrink
            }
        }
        return cell
    }
    
    func recipesRemoveCell(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            savedRecipes.remove(at: indexPath.row)
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
            savedRecipes.append(drink)
        } else if let notification = notification.userInfo as? [String: ParcedMeal] {
            guard let meal = notification["meal"] else { return }
            savedRecipes.append(meal)
        }
    }
}
