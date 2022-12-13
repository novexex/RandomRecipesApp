//
//  DrinkViewController.swift
//  testSfera
//
//  Created by Artour Ilyasov on 01.12.2022
//

import UIKit
import Kingfisher

protocol DrinkViewProtocol: AnyObject {
    func viewInput(description: String, image: UIImageView)
    func refreshView()
    func startActivityIndicator()
    func stopActivityIndicator()
}

class DrinkViewController: BaseViewController {
    var presenter: DrinkPresenterProtocol? {
        didSet {
            presenter?.viewDidLoaded()
        }
    }
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let activityIndicator = UIActivityIndicatorView()
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
        presenter?.buttonNextPressed()
    }
    
    override func navBarRightButtonHandler() {
        presenter?.buttonSavePressed()
    }
    
    override func setupViews() {
        DispatchQueue.main.async {
            super.setupViews()
            self.view.addSubview(self.scrollView)
            self.scrollView.addSubview(self.contentView)
        }
    }
    
    override func constraintViews() {
        DispatchQueue.main.async {
            super.constraintViews()
            
            self.subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
            self.imageView.translatesAutoresizingMaskIntoConstraints = false
            self.scrollView.translatesAutoresizingMaskIntoConstraints = false
            self.contentView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                self.scrollView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                self.scrollView.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: 100),
                self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
                self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
                
                self.contentView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
                self.contentView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor),
                self.contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
                self.contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor)
            ])
            
            self.contentView.addSubview(self.imageView)
            
            NSLayoutConstraint.activate([
                self.imageView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
                self.imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: -150),
                self.imageView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 3/4)
            ])
            
            self.contentView.addSubview(self.subtitleLabel)
            
            NSLayoutConstraint.activate([
                self.subtitleLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
                self.subtitleLabel.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: -150),
                self.subtitleLabel.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 3/4),
                self.subtitleLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
            ])
        }
    }
}

extension DrinkViewController: DrinkViewProtocol {
    func viewInput(description: String, image: UIImageView) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.subtitleLabel = {
                let subtitleLabel = UILabel()
                subtitleLabel.text = description
                subtitleLabel.numberOfLines = 0
                subtitleLabel.sizeToFit()
                subtitleLabel.textColor = UIColor.black
                return subtitleLabel
            }()
            self.imageView = {
                let imageView = image
                imageView.contentMode = .scaleAspectFit
                return imageView
            }()
            self.constraintViews()
            self.stopActivityIndicator()
        }
    }
    
    func refreshView() {
        DispatchQueue.main.async {
            self.scrollView.removeFromSuperview()
            self.contentView.removeFromSuperview()
            self.imageView.removeFromSuperview()
            self.subtitleLabel.removeFromSuperview()
            self.setupViews()
        }
    }
    
    func startActivityIndicator() {
        DispatchQueue.main.async {
            self.view.addSubview(self.activityIndicator)
            self.activityIndicator.pin(to: self.view)
            self.activityIndicator.startAnimating()
            self.activityIndicator.isHidden = false
        }
    }
    
    func stopActivityIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
            self.activityIndicator.removeFromSuperview()
        }
    }
}
