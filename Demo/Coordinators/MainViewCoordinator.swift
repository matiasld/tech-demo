//
//  MainViewCoordinator.swift
//  Demo
//
//  Created by Matias Ladelfa on 10/01/2021.
//

import UIKit

class MainViewCoordinator {
    weak var rootNav: UINavigationController?
    var rootView: MainViewController?

    init(_ nav: UINavigationController) {
        rootView = MainViewController(nibName: Constants.XibName.mainViewController, bundle: nil)
        rootNav = nav
    }

    func start() {
        guard let rootView = rootView else { return }
        rootNav?.pushViewController(rootView, animated: false)
        self.rootView = nil
    }
}
