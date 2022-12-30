//
//  FavoritesRouter.swift
//  testSfera
//
//  Created by Artour Ilyasov on 01.12.2022
//

import Foundation

protocol FavoritesRouterProtocol {
    func setupNotification()
    func detailView(recipeEntity: AnyObject)
}

class FavoritesRouter {
    weak var presenter: FavoritesPresenterProtocol?
    private let notificationCenter = NotificationCenter.default
    
    init() {
        setupNotification()
    }
    
    deinit {
        notificationCenter.removeObserver(self)
    }
    
    @objc func getEntity(notification: Notification) {
        presenter?.routerOutput(notification: notification)
    }
}

extension FavoritesRouter: FavoritesRouterProtocol {
    func setupNotification() {
        notificationCenter.addObserver(self, selector: #selector(getEntity(notification:)), name: .sendEntityNotification, object: nil)
    }
    
    func detailView(recipeEntity: AnyObject) {
        let vc = DetailCellBuilder.build(entity: recipeEntity)
        presenter?.routerOutput(vc: vc)
    }
}
