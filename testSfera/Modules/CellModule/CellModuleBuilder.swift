//
//  CellModuleBuilder.swift
//  testSfera
//
//  Created by Artour Ilyasov on 04.12.2022
//

import UIKit

class CellModuleBuilder {
    static func build() -> CellViewController {
        let interactor = CellInteractor()
        let router = CellRouter()
        let presenter = CellPresenter(interactor: interactor, router: router)
        let storyboard = UIStoryboard(name: "Cell", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "Cell") as! CellViewController
        presenter.view  = viewController
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
