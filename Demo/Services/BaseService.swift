//
//  BaseService.swift
//  Demo
//
//  Created by Matias Ladelfa on 09/01/2021.
//

import Alamofire

typealias CompletionHandler = ((Any) -> Void)

/// Core class to handle a network services.
class BaseService {
    private var manager: Session
    
    /// Service initializer.
    /// - Parameters:
    ///   - adapter: Provide an adapter to make changes to the request if desired. Default adapter makes no changes to the request.
    ///   - retrier: Provide a retrier with a custom retry policy. Default is nil.
    ///   - configuration: Custom URLSession configuration if needed.
    ///   - timeout: Custom timeout if needed.
    init(adapter: RequestAdapter? = nil, retrier: RequestRetrier? = nil, configuration: URLSessionConfiguration = URLSessionConfiguration.default) {
        
        if let retrier = retrier, let adapter = adapter {
            // Initialize service with retrier and adapter.
            let interceptor = Interceptor.init(adapter: adapter, retrier: retrier)
            manager = Alamofire.Session(configuration: configuration, interceptor: interceptor)
        } else {
            // Initialize service by default Alamofire settings.
            manager = Alamofire.Session(configuration: configuration)
        }
        
    }
    
    // MARK: - Public Methods
    /// Initiates a service call to the specified request URL.
    /// - Parameters:
    ///   - requestUrl: URL to make the request.
    ///   - method: HTTP method to use, i.e. GET, POST, DELETE, etc.
    ///   - params: A dictionary of parameters to apply to a URLRequest.
    ///   - paramEncoding: A type used to define how a set of parameters are applied to a URLRequest.
    ///   - completion: Optional completion handler.
    func sendCall(requestUrl: String, method: HTTPMethod, params: Parameters?, paramEncoding: ParameterEncoding, completion: CompletionHandler?) {

        let headers: HTTPHeaders = HTTPHeaders()
        
        let request = manager.request(requestUrl, method: method, parameters: params, encoding: paramEncoding, headers: headers)
        request.response { response in

            guard response.error == nil else {
                // Some error happened.
                NSLog("Request error: \(response.error.debugDescription)")
                self.responseOfCall(responseData: nil, response: nil, completion: completion)
                return
            }

            self.responseOfCall(responseData: response.data, response: response, completion: completion)
        }
    }
    
    /// Response handler method to be overwritten.
    /// - Parameters:
    ///   - responseData: Data extracted from original response.
    ///   - response: Complete response.
    ///   - completion: Optional completion handler.
    func responseOfCall(responseData: Data?, response: AFDataResponse<Data?>?, completion: CompletionHandler?) {
        NSLog("\(String(describing: response?.response?.statusCode))")
    }
}
