//
//  MealRouter.swift
//  testSfera
//
//  Created by Artour Ilyasov on 01.12.2022
//

import Foundation

protocol MealRouterProtocol {
    func post(meal: ParcedMeal)
}

class MealRouter {
    weak var presenter: MealPresenterProtocol?
    private let notificationCenter = NotificationCenter.default
}

extension MealRouter: MealRouterProtocol {
    func post(meal: ParcedMeal) {
        notificationCenter.post(name: .sendEntityNotification, object: self, userInfo: [Resources.DictKeys.meal:meal])
    }
}
