//
//  BaseController.swift
//  testSfera
//
//  Created by Artour Ilyasov on 30.11.2022.
//

import UIKit

enum NavBarPosition {
    case left
    case right
}

class BaseController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
}

@objc extension BaseController {
    func addViews() {}
    func configure() {
        view.backgroundColor = Resources.Colors.background
    }
    func layoutViews() {}
    func navBarLeftButtonHandler() {
        print("NavBar left button tapped")
    }
    
    func navBarRightButtonHandler() {
        print("NavBar right button tapped")
    }
}

extension BaseController {
    func addNavBarButton(at position: NavBarPosition, with title: String) {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(Resources.Colors.active, for: .normal)
        button.titleLabel?.font = Resources.Fonts.helveticaRegular(with: 17)
        //button.setImage(<#T##image: UIImage?##UIImage?#>, for: <#T##UIControl.State#>)
        
        switch position {
        case .left:
            button.addTarget(self, action: #selector(navBarLeftButtonHandler), for: .touchUpInside)
            navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
        case .right:
            button.addTarget(self, action: #selector(navBarRightButtonHandler), for: .touchUpInside)
            navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
        }
    }
}
