//
//  FavoritesController.swift
//  testSfera
//
//  Created by Artour Ilyasov on 30.11.2022.
//

import UIKit

class FavoritesController: BaseController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = Resources.Titles.NavBar.favorites
        navigationController?.tabBarItem.title = Resources.Titles.TabBar.favorites
    }
}
