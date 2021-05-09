//
//  MainCoordinator.swift
//  Homegate_t
//
//  Created by Pavle Mijatovic on 9.5.21..
//

import UIKit

class MainCoordinator: Coordinator {
    var childCoordinator = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = HomesCVC.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}
