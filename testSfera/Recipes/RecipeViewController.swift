//
//  ViewController.swift
//  testSfera
//
//  Created by Artour Ilyasov on 28.11.2022.
//

import UIKit

protocol RecipeViewProtocol: AnyObject {
    
}

class RecipeViewController: UIViewController {
    var presenter: RecipePresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoaded()
    }


}

extension RecipeViewController: RecipeViewProtocol {
    
}
