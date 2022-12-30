//
//  FavoritesInteractor.swift
//  testSfera
//
//  Created by Artour Ilyasov on 01.12.2022
//

protocol FavoritesInteractorProtocol: AnyObject {
}

class FavoritesInteractor: FavoritesInteractorProtocol {
    weak var presenter: FavoritesPresenterProtocol?
}
