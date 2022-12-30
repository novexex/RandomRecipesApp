//
//  URL.swift
//  testSfera
//
//  Created by Artour Ilyasov on 10.12.2022.
//

import UIKit
import Kingfisher

extension UIImageView {
    func getImageFromURL(url: String) -> UIImageView {
        let imageView = UIImageView()
        let url = URL(string: url)
        imageView.kf.setImage(with: url)
        return imageView
    }
}
