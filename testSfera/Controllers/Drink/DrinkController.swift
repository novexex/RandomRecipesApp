//
//  DrinkController.swift
//  testSfera
//
//  Created by Artour Ilyasov on 30.11.2022.
//

import UIKit

class DrinkController: BaseController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = Resources.Titles.NavBar.drink
        navigationController?.tabBarItem.title = Resources.Titles.TabBar.drink
        addNavBarButton(at: .left, with: Resources.Titles.NavBar.Actions.left)
        addNavBarButton(at: .right, with: Resources.Titles.NavBar.Actions.right)
    }
    
    override func navBarLeftButtonHandler() {
        print("Drink NavBar button Next tapped")
    }
    
    override func navBarRightButtonHandler() {
        print("Drink NavBar button Save tapped")
    }
}
