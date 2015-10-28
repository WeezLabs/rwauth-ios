//
//  NetworkManager.swift
//  RWAuth
//
//  Created by Роман on 22.10.15.
//  Copyright © 2015 weezlabs. All rights reserved.
//

import Foundation

class NetworkManager: NSObject {
    
    static let sharedManager: NetworkManager = NetworkManager()
    static let scheme = "http"
    static let host = "exampledomain.com"
    
    var session: NSURLSession
    
    enum HTTPMethod: String {
        case POST = "POST"
        case PUT = "PUT"
    }
    
    override init() {
        let sessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
        self.session = NSURLSession(configuration: sessionConfiguration)
    }
    
    class func request(method: HTTPMethod, path: AuthPath, body: [String: String], completion: (response: Any) -> Void) {
        let session = NetworkManager.sharedManager.session
        var response = Response<String, NSError>()
        guard let url = NSURL(scheme: scheme, host: host, path: path.rawValue) else {
            let result = Result<String, NSError>.Failure(NetworkError.InvalidURL as NSError)
            response.result = result
            completion(response: response)
            return
        }
        
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = method.rawValue
        response.request = request
        
        let bodyData = try? NSJSONSerialization.dataWithJSONObject(body, options: NSJSONWritingOptions(rawValue: 0))
        let uploadTask = session.uploadTaskWithRequest(request, fromData: bodyData) {
            (innerData: NSData?, innerResponse: NSURLResponse?, error: NSError?) -> Void in
            let result: Result<String, NSError>
            
            if let error = error {
                result = Result.Failure(error)
            } else {
                result = Result.Success("Success")
            }
            
            response = Response(request: request, response: innerResponse, data: innerData, result: result)
            completion(response: response)
        }
        
        uploadTask.resume()
    }
}


