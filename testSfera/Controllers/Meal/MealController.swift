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
        
        //MARK: Image
        let image = UIImage(named: "meal")
        let imageView = UIImageView(frame: view.bounds)
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        
        
        //MARK: Label
        let label = UILabel()
        label.text = "This Shepherd's Pie is vegetarian comfort food at its best. Carrots, mushrooms, peas, and green beans bathed in a creamy sauce and topped with cheesy mashed potatoes make a diner's delight! This Shepherd's Pie is vegetarian comfort food at its best. Carrots, mushrooms, peas, and green beans bathed in a creamy sauce and topped with cheesy mashed potatoes make a diner's delight! This Shepherd's Pie is vegetarian comfort food at its best. Carrots, mushrooms, peas, and green beans bathed in a creamy sauce and topped with cheesy mashed potatoes make a diner's delight! This Shepherd's Pie is vegetarian comfort food at its best. Carrots, mushrooms, peas, and green beans bathed in a creamy sauce and topped with cheesy mashed potatoes make a diner's delight! This Shepherd's Pie is vegetarian comfort food at its best. Carrots, mushrooms, peas, and green beans bathed in a creamy sauce and topped with cheesy mashed potatoes make a diner's delight! "
        label.numberOfLines = 0
        
        //MARK: Add Subviews
        view.addSubview(imageView)
        view.addSubview(label)
        
        // MARK: Constraints
        imageView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -19),
            imageView.heightAnchor.constraint(equalToConstant: 300),

            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor)
        ])
        
    }
    
    override func navBarLeftButtonHandler() {
        print("Meal NavBar button Next tapped")
    }
    
    override func navBarRightButtonHandler() {
        print("Meal NavBar button Save tapped")
    }
}

