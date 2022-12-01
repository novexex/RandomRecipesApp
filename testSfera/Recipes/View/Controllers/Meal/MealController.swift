//
//  MealController.swift
//  testSfera
//
//  Created by Artour Ilyasov on 30.11.2022.
//

import UIKit

class MealController: RecipeBaseViewController {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    let imageView: UIImageView = {
        let image = UIImage(named: "meal1")
        let imageView = UIImageView()
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Put the sliced chicken in a mixing bowl and add the egg white, 1 tsp salt and 1 tsp oil. Massage into the chicken to make sure it’s thoroughly coated. Set aside. Heat 2 tbsp vegetable oil in a large lidded wok or a deep frying pan set over a medium heat on your largest hob ring. Once the oil is slightly glistening, add the chopped shallot and stir until slightly golden in colour, about 3 mins. Add the chopped garlic and fry for 30 seconds. Still on medium heat, add the marinated chicken to the wok. Keep stir-frying until 70% of the chicken has changed from opaque to white. It doesn’t need to be fully cooked yet. If the chicken is sticking to the pan, add another 1 tbsp oil. Add the onion, mushrooms and carrots and toss with the chicken. Using two spatulas makes this easier. Stir-fry for another 30 seconds, on medium heat. Turn off the heat, then add the soy sauce, rice wine, white pepper, chicken bouillon, sugar and 150ml water. Stir gently then turn the heat back on to high. Add the egg noodles and, using tongs, gently toss for about 15 seconds to make sure they're thoroughly coated with the sauce. Add the cabbage on top of the noodles without mixing it in, put a lid on and let it steam for 30 seconds. Remove the lid, then mix the softened cabbage in with the noodles for about 10 seconds. Replace the lid and steam for another 30 seconds. Remove the lid and gently toss, being careful not to break the noodles. Add the chopped spring onion on top and splash in the 1 tbsp black vinegar or Worcestershire sauce on the wall of the wok, in a half circle motion. Give a final gentle toss to work in the spring onion. Serve straightaway on a platter."
        label.numberOfLines = 0
        label.sizeToFit()
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Resources.Titles.NavBar.meal
        navigationController?.tabBarItem.title = Resources.Titles.TabBar.meal
        addNavBarButton(at: .left, with: Resources.Titles.NavBar.Actions.left)
        addNavBarButton(at: .right, with: Resources.Titles.NavBar.Actions.right)
        
        setupViews()
        constraintViews()
    }
    
    override func navBarLeftButtonHandler() {
        print("Meal NavBar button Next tapped")
    }
    
    override func navBarRightButtonHandler() {
        print("Meal NavBar button Save tapped")
    }
}

extension MealController {
    override func setupViews() {
        super.setupViews()
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
    }

    override func constraintViews() {
        super.constraintViews()
        
        NSLayoutConstraint.activate([
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 100),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
        
        contentView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 3/4)
        ])
        
        contentView.addSubview(subtitleLabel)
        
        NSLayoutConstraint.activate([
            subtitleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 25),
            subtitleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 3/4),
            subtitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
