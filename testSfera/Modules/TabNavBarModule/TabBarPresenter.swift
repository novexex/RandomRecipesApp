//
//  TabBarPresenter.swift
//  testSfera
//
//  Created by Artour Ilyasov on 28.11.2022.
//

protocol TabBarPresenterProtocol: AnyObject {
    func viewDidLoaded()
}

class TabBarPresenter {
    weak var view: TabBarBaseViewProtocol?
    var router: TabBarRouterProtocol
    var interactor: TabBarInteractorProtocol
    
    init(router: TabBarRouterProtocol, interactor: TabBarInteractorProtocol) {
        self.router = router
        self.interactor = interactor
    }
}

extension TabBarPresenter: TabBarPresenterProtocol {
    func didLoad(meal: Meal) {
        //print(meal.meals)
    }
    
    func didLoad(drink: Drink) {
    }
    
    func viewDidLoaded() {
        router.setupViews()
    }
}
