//
//  FavoritesRouter.swift
//  testSfera
//
//  Created by Artour Ilyasov on 01.12.2022
//

protocol FavoritesRouterProtocol {
    func detailView(recipeEntity: AnyObject)
}

class FavoritesRouter: FavoritesRouterProtocol {
    func detailView(recipeEntity: AnyObject) {
        let vc = DetailCellBuilder.build(mealEntity: recipeEntity)
        viewController?.present(vc, animated: true)
    }
    
    weak var viewController: FavoritesViewController?
}
