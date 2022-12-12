//
//  DrinkViewController.swift
//  testSfera
//
//  Created by Artour Ilyasov on 01.12.2022
//

import UIKit

protocol DrinkViewProtocol: AnyObject {
    func viewInput(description: String, image: UIImage)
}

class DrinkViewController: BaseViewController {
    var presenter: DrinkPresenterProtocol? {
        didSet {
            presenter?.viewDidLoaded()
        }
    }
    private var scrollView = UIScrollView()
    private var contentView = UIView()
    private var imageView = UIImageView()
    private var subtitleLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Resources.Titles.NavBar.drink
        navigationController?.tabBarItem.title = Resources.Titles.TabBar.drink
        addNavBarButton(at: .left, with: Resources.Titles.NavBar.Actions.left)
        addNavBarButton(at: .right, with: Resources.Titles.NavBar.Actions.right)
        setupViews()
    }
    
    override func navBarLeftButtonHandler() {
        view.subviews.forEach({ $0.removeFromSuperview() })
        scrollView = UIScrollView()
        contentView = UIView()
        imageView = UIImageView()
        subtitleLabel = UILabel()
        setupViews()
        presenter?.viewOutput()
    }
    
    override func navBarRightButtonHandler() {
        presenter?.buttonSavePressed()
    }
}

extension DrinkViewController: DrinkViewProtocol {
    func viewInput(description: String, image: UIImage) {
        DispatchQueue.main.async {
            self.subtitleLabel = {
                let label = UILabel()
                label.text = description
                label.numberOfLines = 0
                label.sizeToFit()
                label.textColor = UIColor.black
                return label
            }()
            self.imageView = {
                let imageView = UIImageView()
                imageView.image = image
                imageView.contentMode = .scaleAspectFit
                return imageView
            }()
            self.constraintViews()
        }
    }
    

    override func setupViews() {
        super.setupViews()
        
        scrollView.addSubview(contentView)
        contentView.addSubview(imageView)
        contentView.addSubview(subtitleLabel)
        view.addSubview(scrollView)
    }
    
    override func constraintViews() {
        super.constraintViews()

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 100),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),

            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: -150),
            imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 3/4),

            subtitleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -150),
            subtitleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 3/4),
            subtitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
