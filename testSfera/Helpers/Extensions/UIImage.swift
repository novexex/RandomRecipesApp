//
//  URL.swift
//  testSfera
//
//  Created by Artour Ilyasov on 10.12.2022.
//

import Foundation
import UIKit

extension UIImage {
    func getImageFromString(url: String) -> UIImage {
        let urlImage = URL(string: url)
        
        guard let urlImage else { return UIImage() }
        
        let data = try? Data(contentsOf: urlImage)
        
        guard let data else { return UIImage() }
        let image = UIImage(data: data)
        
        guard let image else { return UIImage() }
        
        return image
    }
    
    func getImageFromURL(url: URL) -> UIImage {
        var image = UIImage()
        let asd = URLSession.shared.dataTask(with: url) { (data, response, error) in
            // Error handling...
            guard let imageData = data else { return }
            
            DispatchQueue.main.async {
                image = UIImage(data: imageData)!
            }
        }
        asd.resume()
        return image
    }
    
    func getImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, let img = UIImage(data: data) {
                completion(img)
            } else {
                completion(nil)
            }
        }.resume()
    }
}
