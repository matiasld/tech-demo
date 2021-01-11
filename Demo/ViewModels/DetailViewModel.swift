//
//  DetailViewModel.swift
//  Demo
//
//  Created by Matias Ladelfa on 10/01/2021.
//

import UIKit

class DetailViewModel {
    
    var title: String
    var description: String
    var placeholder: UIImage
    
    init(title: String, description: String, placeholder: UIImage) {
        self.title = title
        self.description = description
        self.placeholder = placeholder
    }
}
