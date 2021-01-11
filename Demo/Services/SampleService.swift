//
//  SampleService.swift
//  Demo
//
//  Created by Matias Ladelfa on 10/01/2021.
//

import Foundation
import Alamofire

/// Service class in charge of retrieving Sample data.
class SampleService: BaseService {
    
    // MARK: - Call Response
    override func responseOfCall(responseData: Data?, response: AFDataResponse<Data?>?, completion: CompletionHandler?) {

        guard let data = responseData else {
            NSLog("Invalid data response.")
            completion?(0)
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let sampleData = try decoder.decode(Sample.self, from: data)
            
            completion?(sampleData)
            
        } catch {
            NSLog("Couldn't decode incoming data.")
            completion?(0)
        }
    }
    
    // MARK: - Request Methods
    /// Sends call to retrieve sample data.
    /// - Parameters:
    ///     - completion: Completion handler.
    func requestData(completion: @escaping CompletionHandler) {
        let requestUrl = Constants.General.sampleURL
        sendCall(requestUrl: requestUrl, method: .get, params: nil, paramEncoding: URLEncoding.default, completion: completion)
    }
}
