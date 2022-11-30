//
//  MealController.swift
//  testSfera
//
//  Created by Artour Ilyasov on 30.11.2022.
//

import UIKit

class MealController: BaseController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Resources.Titles.NavBar.meal
        navigationController?.tabBarItem.title = Resources.Titles.TabBar.meal
        addNavBarButton(at: .left, with: Resources.Titles.NavBar.Actions.left)
        addNavBarButton(at: .right, with: Resources.Titles.NavBar.Actions.right)
    }
    
    override func navBarLeftButtonHandler() {
        print("Meal NavBar button Next tapped")
    }
    
    override func navBarRightButtonHandler() {
        print("Meal NavBar button Save tapped")
    }
}
