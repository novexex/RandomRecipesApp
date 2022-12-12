//
//  DetailCellViewController.swift
//  testSfera
//
//  Created by Artour Ilyasov on 12.12.2022
//

import UIKit

protocol DetailCellViewProtocol: AnyObject {
    func viewInput(description: String, image: UIImage)
}

class DetailCellViewController: UIViewController {
    var presenter: DetailCellPresenterProtocol? {
        didSet {
            presenter?.viewDidLoad()
        }
    }
    var scrollView = UIScrollView()
    var contentView = UIView()
    var imageView = UIImageView()
    var subtitleLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
    }
}

extension DetailCellViewController: DetailCellViewProtocol {
    func viewInput(description: String, image: UIImage) {
        DispatchQueue.main.async {
            let subtitleLabel: UILabel = {
                let label = UILabel()
                label.text = description
                label.numberOfLines = 0
                label.sizeToFit()
                label.textColor = UIColor.black
                label.translatesAutoresizingMaskIntoConstraints = false
                return label
            }()
            let imageView: UIImageView = {
                let imageView = UIImageView()
                imageView.image = image
                imageView.contentMode = .scaleAspectFit
                imageView.translatesAutoresizingMaskIntoConstraints = false
                return imageView
            }()
            self.subtitleLabel = subtitleLabel
            self.imageView = imageView
            self.constraintViews()
        }
    }

    func setupViews() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
    }

    func constraintViews() {
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
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: -150),
            imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 3/4)
        ])
        
        contentView.addSubview(subtitleLabel)
        
        NSLayoutConstraint.activate([
            subtitleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -150),
            subtitleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 3/4),
            subtitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
}
