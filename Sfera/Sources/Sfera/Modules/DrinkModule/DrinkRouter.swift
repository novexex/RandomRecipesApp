//
//  DrinkRouter.swift
//  testSfera
//
//  Created by Artour Ilyasov on 01.12.2022
//

import Foundation

protocol DrinkRouterProtocol {
    func post(drink: ParcedDrink)
}

class DrinkRouter {
    weak var presenter: DrinkPresenterProtocol?
    let notificationCenter = NotificationCenter.default
}

extension DrinkRouter: DrinkRouterProtocol {
    func post(drink: ParcedDrink) {
        notificationCenter.post(name: .sendEntityNotification, object: self, userInfo: [Resources.DictKeys.drink:drink])
    }
}
