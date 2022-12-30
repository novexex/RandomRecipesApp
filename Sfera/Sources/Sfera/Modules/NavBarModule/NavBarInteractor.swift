//
//  NavBarInteractor.swift
//  testSfera
//
//  Created by Artour Ilyasov on 01.12.2022
//

protocol NavBarInteractorProtocol: AnyObject {}

class NavBarInteractor: NavBarInteractorProtocol {
    weak var presenter: NavBarPresenterProtocol?
}
