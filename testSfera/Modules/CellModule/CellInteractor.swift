//
//  CellInteractor.swift
//  testSfera
//
//  Created by Artour Ilyasov on 04.12.2022
//

protocol CellInteractorProtocol: AnyObject {
}

class CellInteractor: CellInteractorProtocol {
    weak var presenter: CellPresenterProtocol?
}
