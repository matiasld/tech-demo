//
//  Sample.swift
//  Demo
//
//  Created by Matias Ladelfa on 09/01/2021.
//

import Foundation


// MARK: - SampleElement
typealias Sample = [SampleElement]

class SampleElement: Decodable {
    let title, description, image: String?

    init(title: String?, sampleDescription: String?, image: String?) {
        self.title = title
        self.description = sampleDescription
        self.image = image
    }
}
