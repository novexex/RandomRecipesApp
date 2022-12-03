//
//  NavBarPresenter.swift
//  Super easy dev
//
//  Created by Artour Ilyasov on 01.12.2022
//

protocol NavBarPresenterProtocol: AnyObject {
}

class NavBarPresenter {
    weak var view: NavBarViewProtocol?
    var router: NavBarRouterProtocol
    var interactor: NavBarInteractorProtocol

    init(interactor: NavBarInteractorProtocol, router: NavBarRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension NavBarPresenter: NavBarPresenterProtocol {
}
