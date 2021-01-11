//
//  DetailViewController.swift
//  Demo
//
//  Created by Matias Ladelfa on 10/01/2021.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var viewModel: DetailViewModel?
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - View Configuration
    /// View's initial configuration.
    private func setupView() {
        guard let viewModel = viewModel else { return }
        titleLabel.text = viewModel.title
        // Adjust description label to use as many space as needed.
        descriptionLabel.numberOfLines = 0
        descriptionLabel.text = viewModel.description
        imageView.image = viewModel.placeholder
        
        if viewModel.placeholder == UIImage(systemName: Constants.General.defaultIcon) {
            imageView.contentMode = .center
        }
    }
}
