//
//  SampleCell.swift
//  Demo
//
//  Created by Matias Ladelfa on 10/01/2021.
//

import UIKit
import SDWebImage

class SampleCell: UITableViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // MARK: - View lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.layoutIfNeeded()
    }
    
    // MARK: - Configuration
    
    /// Configures each cell given the passed parameters.
    /// - Parameters:
    ///   - title: Given title text.
    ///   - description: Given description text.
    ///   - url: URL needed to download associated image.
    func configure(title: String?, description: String?, url : String?) {
        
        // Try to validate mandatory parameters.
        guard let title = title,
              let description = description else { return }
        
        titleLabel.text = title
        descriptionLabel.text = description
        
        // Try to download image. Optional parameter.
        guard let validUrl = url else { return }
        profileImage.contentMode = .scaleAspectFill
        profileImage.sd_setImage(with: URL(string: validUrl),
                                 placeholderImage: UIImage(systemName: Constants.General.defaultIcon),
                                 options: .highPriority,
                                 context: nil)
    }
}
