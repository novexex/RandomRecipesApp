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
        return mealEntity
    }
    
    weak var presenter: DetailCellPresenterProtocol?
    let mealEntity: AnyObject
    
    init(mealEntity: AnyObject) {
        self.mealEntity = mealEntity
    }
}
