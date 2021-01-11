//
//  AppCoordinator.swift
//  Demo
//
//  Created by Matias Ladelfa on 10/01/2021.
//

import UIKit

class AppCoordinator {
    // A window is connected in order to override the default view system of cocoa.
    var window: UIWindow?
    var rootNav: UINavigationController?
    
    init(_ nav: UINavigationController, _ window: UIWindow) {
        self.window = window
        self.window?.makeKeyAndVisible()
        rootNav = nav
    }

    /// Launches starting view for the App.
    func start() {
        window?.rootViewController = rootNav
        
        guard let rootNav = rootNav else { return }
        let mainView = MainViewCoordinator(rootNav)
        mainView.start()
    }
}
