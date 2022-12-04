//
//  CellPresenter.swift
//  testSfera
//
//  Created by Artour Ilyasov on 04.12.2022
//

protocol CellPresenterProtocol: AnyObject {
}

class CellPresenter {
    weak var view: CellViewProtocol?
    var router: CellRouterProtocol
    var interactor: CellInteractorProtocol

    init(interactor: CellInteractorProtocol, router: CellRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension CellPresenter: CellPresenterProtocol {
}
