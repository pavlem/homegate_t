//
//  AppDelegate.swift
//  Homegate_t
//
//  Created by Pavle Mijatovic on 9.5.21..
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: MainCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setRootVC()
        return true
    }
    
    func setRootVC() {
        let nc = UINavigationController()
        coordinator = MainCoordinator(navigationController: nc)
        coordinator?.start()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = nc
        window?.makeKeyAndVisible()
    }
}

