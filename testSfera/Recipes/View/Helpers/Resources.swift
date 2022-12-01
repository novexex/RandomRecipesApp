//
//  Resources.swift
//  testSfera
//
//  Created by Artour Ilyasov on 30.11.2022.
//

import UIKit

enum Resources {
    enum Colors {
        static let active = UIColor(hexString: "#437BFE")
        static let inActive = UIColor(hexString: "#929DA5")
        static let separator = UIColor(hexString: "#E8ECEF")
        static let titleGray = UIColor(hexString: "#545C77")
        static let background = UIColor(hexString: "#F8F9F9")
    }
    
    enum Titles {
        enum TabBar {
            static let meal = "Random Meal"
            static let drink = "Random Drink"
            static let favorites = "Saved Recipes"
        }
        enum NavBar {
            enum Actions {
                static let left = "Next"
                static let right = "Save"
            }
            static let favorites = "Favorites Recipes"
            static let meal = "Meal Recipe"
            static let drink = "Drink Recipe"
        }
        
    }
    
    enum Images {
        static let meal = UIImage(systemName: "fork.knife")
        static let drink = UIImage(systemName: "wineglass")
        static let favorites = UIImage(systemName: "bookmark")
    }
    
    enum Fonts {
        static func helveticaRegular(with size: CGFloat) -> UIFont {
            UIFont(name: "Helvetica", size: size) ?? UIFont()
        }
    }
}
