//
//  Resources.swift
//  testSfera
//
//  Created by Artour Ilyasov on 30.11.2022.
//

import UIKit

enum Resources {
    enum Colors {
        static var active = UIColor(hexString: "#437BFE")
        static var inActive = UIColor(hexString: "#929DA5")
        static var separator = UIColor(hexString: "#E8ECEF")
        static var titleGray = UIColor(hexString: "#545C77")
        static var background = UIColor(hexString: "#F8F9F9")
    }
    
    enum Titles {
        enum TabBar {
            static var meal = "Random Meal"
            static var drink = "Random Drink"
            static var favorites = "Saved Recipes"
        }
        enum NavBar {
            enum Actions {
                static var left = "Next"
                static var right = "Save"
            }
            static var favorites = "Favorites Recipes"
            static var meal = "Meal Recipe"
            static var drink = "Drink Recipe"
        }
        
    }
    
    enum Images {
        static var meal = UIImage(systemName: "fork.knife")
        static var drink = UIImage(systemName: "wineglass")
        static var favorites = UIImage(systemName: "bookmark")
    }
    
    enum Fonts {
        static func helveticaRegular(with size: CGFloat) -> UIFont {
            UIFont(name: "Helvetica", size: size) ?? UIFont()
        }
    }
}
