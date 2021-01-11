//
//  DetailViewCoordinator.swift
//  Demo
//
//  Created by Matias Ladelfa on 10/01/2021.
//

import UIKit

class DetailViewCoordinator {
    weak var rootNav: UINavigationController?
    var rootView: DetailViewController?

    init(_ nav: UINavigationController, title: String, description: String, placeholder: UIImage) {
        rootView = DetailViewController(nibName: Constants.XibName.detailViewController, bundle: nil)
        rootView?.viewModel = DetailViewModel(title: title, description: description, placeholder: placeholder)
        rootNav = nav
    }

    func start() {
        guard let rootView = rootView else { return }
        rootNav?.pushViewController(rootView, animated: true)
        self.rootView = nil
    }
}
