//
//  CellViewController.swift
//  testSfera
//
//  Created by Artour Ilyasov on 04.12.2022
//

import UIKit

protocol CellViewProtocol: AnyObject {
}

class CellViewController: UIViewController {
    // MARK: - Public
    var presenter: CellPresenterProtocol?

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
}

// MARK: - Private functions
private extension CellViewController {
    func initialize() {
    }
}

// MARK: - CellViewProtocol
extension CellViewController: CellViewProtocol {
}
