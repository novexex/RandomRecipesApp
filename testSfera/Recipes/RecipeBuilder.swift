//
//  RecipeBuilder.swift
//  testSfera
//
//  Created by Artour Ilyasov on 28.11.2022.
//

import UIKit

class RecipeBuilder {
    static func build() -> RecipeViewController {
        let interactor = RecipeInteractor()
        let router = RecipeRouter()
        let presenter = RecipePresenter(router: router, interactor: interactor)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "Main") as! RecipeViewController
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        router.viewController = viewController
        
        return viewController
    }
}
