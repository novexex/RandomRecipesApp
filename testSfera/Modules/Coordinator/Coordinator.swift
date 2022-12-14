//
//  Coordinator.swift
//  testSfera
//
//  Created by Artour Ilyasov on 13.12.2022.
//

import Foundation
import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}
