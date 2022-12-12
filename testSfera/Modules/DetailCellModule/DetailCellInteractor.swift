//
//  DetailCellInteractor.swift
//  testSfera
//
//  Created by Artour Ilyasov on 12.12.2022
//

protocol DetailCellInteractorProtocol: AnyObject {
    func getDetailEntity() -> AnyObject
}

class DetailCellInteractor: DetailCellInteractorProtocol {
    func getDetailEntity() -> AnyObject {
        return entity
    }
    
    weak var presenter: DetailCellPresenterProtocol?
    let entity: AnyObject
    
    init(entity: AnyObject) {
        self.entity = entity
    }
}
