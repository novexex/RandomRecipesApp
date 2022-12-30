//
//  BaseViewController.swift
//  testSfera
//
//  Created by Artour Ilyasov on 28.11.2022.
//

import UIKit

enum NavBarPosition {
    case left
    case right
}

public class BaseViewController: UIViewController {
    
    var buttons = [UIButton]()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        configureAppearance()
    }
}

@objc extension BaseViewController {
    func setupViews() {}
    func configureAppearance() {
        view.backgroundColor = Resources.Colors.background
    }
    func constraintViews() {}
    func navBarLeftButtonHandler() {
        print("NavBar left button tapped")
    }
    
    func navBarRightButtonHandler() {
        print("NavBar right button tapped")
    }
}

extension BaseViewController {
    func addNavBarButton(at position: NavBarPosition, with title: String) {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(Resources.Colors.active, for: .normal)
        button.setTitleColor(Resources.Colors.inActive, for: .disabled)
        button.titleLabel?.font = Resources.Fonts.helveticaRegular(with: 17)
        
        buttons.append(button)
        
        switch position {
        case .left:
            button.addTarget(self, action: #selector(navBarLeftButtonHandler), for: .touchUpInside)
            navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
        case .right:
            button.addTarget(self, action: #selector(navBarRightButtonHandler), for: .touchUpInside)
            navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
        }
    }
    
    func disableButtons() {
        for i in buttons {
            i.isEnabled = false
        }
    }
    
    func disableSaveButton() {
        buttons[1].isEnabled = false
    }
    
    func enableSaveButton() {
        buttons[1].isEnabled = true
    }
    
    func enableButtons() {
        for i in buttons {
            i.isEnabled = true
        }
    }
}
