//
//  URL.swift
//  testSfera
//
//  Created by Artour Ilyasov on 10.12.2022.
//

import Foundation
import UIKit

extension UIImage {
    func getImageFromURL(url: String) -> UIImage {
        let urlImage = URL(string: url)
        
        guard let urlImage else { return UIImage() }

        let data = try? Data(contentsOf: urlImage)
        
        guard let data else { return UIImage() }
        let image = UIImage(data: data)

        guard let image else { return UIImage() }
        return image
    }
}
