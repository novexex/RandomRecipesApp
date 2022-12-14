//
//  FavoritesPresenter.swift
//  testSfera
//
//  Created by Artour Ilyasov on 01.12.2022
//

import Foundation

protocol FavoritesPresenterProtocol: AnyObject {
    func detailView(recipeEntity: AnyObject)
    func routerOutput(notification: Notification)
    func routerOutput(vc: DetailCellViewController)
}

class FavoritesPresenter {
    weak var view: FavoritesViewProtocol?
    var router: FavoritesRouterProtocol
    var interactor: FavoritesInteractorProtocol

    init(interactor: FavoritesInteractorProtocol, router: FavoritesRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension FavoritesPresenter: FavoritesPresenterProtocol {
    func routerOutput(vc: DetailCellViewController) {
        view?.presenterOutput(vc: vc)
    }
    
    func routerOutput(notification: Notification) {
        if let notification = notification.userInfo as? [String: ParcedDrink] {
            guard let drink = notification["drink"] else { return }
            view?.getEntity(drink: drink)
        } else if let notification = notification.userInfo as? [String: ParcedMeal] {
            guard let meal = notification["meal"] else { return }
            view?.getEntity(meal: meal)
        }
    }
    
    func detailView(recipeEntity: AnyObject) {
        router.detailView(recipeEntity: recipeEntity)
    }
}
