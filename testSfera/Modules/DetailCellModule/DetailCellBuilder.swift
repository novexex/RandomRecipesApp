//
//  DetailCellModuleBuilder.swift
//  testSfera
//
//  Created by Artour Ilyasov on 12.12.2022
//

import UIKit

class DetailCellBuilder {
    static func build(mealEntity: AnyObject) -> DetailCellViewController {
        let interactor = DetailCellInteractor(mealEntity: mealEntity)
        let router = DetailCellRouter()
        let presenter = DetailCellPresenter(interactor: interactor, router: router)
        let viewController = DetailCellViewController()
        presenter.view  = viewController
        interactor.presenter = presenter
        router.viewController = viewController
        viewController.presenter = presenter
        return viewController
    }
}
