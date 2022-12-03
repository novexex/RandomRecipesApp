//
//  DrinkViewController.swift
//  testSfera
//
//  Created by Artour Ilyasov on 01.12.2022
//

import UIKit

protocol DrinkViewProtocol: AnyObject {
    func viewInput(discription: String, image: UIImage)
    func viewOutput()
}

class DrinkViewController: BaseViewController {
    // MARK: - Public
    var presenter: DrinkPresenterProtocol? {
        didSet {
            presenter?.viewDidLoaded()
        }
    }
    var scrollView = UIScrollView()
    var contentView = UIView()
    var imageView = UIImageView()
    var subtitleLabel = UILabel()
    
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
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
        presenter?.viewInput()
    }
    
    override func navBarRightButtonHandler() {
        print("Drink NavBar button Save tapped")
    }
    
}

// MARK: - Private functions
private extension DrinkViewController {
    func initialize() {
    }
}

// MARK: - DrinkViewProtocol
extension DrinkViewController: DrinkViewProtocol {
    func viewInput(discription: String, image: UIImage) {
        DispatchQueue.main.async {
            let subtitleLabel: UILabel = {
                let label = UILabel()
                label.text = discription
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
    
    func viewOutput() {
        
    }
    
}

extension DrinkViewController {
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
