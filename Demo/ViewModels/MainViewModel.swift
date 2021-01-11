//
//  MainViewModel.swift
//  Demo
//
//  Created by Matias Ladelfa on 10/01/2021.
//

import Foundation

class MainViewModel {
    
    private let service = SampleService()
    var samples: Sample?
    
    // MARK: - Public Methods
    /// Retrieves samples performing url request.
    func getSamples() {
        
        service.requestData { response in
            // Validate and store fetched data.
            guard let validSamples = response as? Sample else { return }
            self.samples = validSamples
            
            // Notify all data has been successfully downloaded.
            NotificationCenter.default.post(name: .samplesDownloaded, object: nil)
        }
    }
}
