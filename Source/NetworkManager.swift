//
//  NetworkManager.swift
//  RWAuth
//
//  Created by Роман on 22.10.15.
//  Copyright © 2015 weezlabs. All rights reserved.
//

import Foundation

class NetworkManager: NSObject {
    
    static let scheme = "http"
    static let host = "exampledomain.com"
    
    private static var storedSession: NSURLSession?
    static var session: NSURLSession? {
        get {
            guard let session = storedSession else {
                let sessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
                return NSURLSession(configuration: sessionConfiguration)
            }
            return session
        }
        set(newSession) {
            storedSession = newSession
        }
    }
    
    enum HTTPMethod: String {
        case POST = "POST"
        case PUT = "PUT"
    }
    
    class func request(method: HTTPMethod, path: AuthPath, body: [String: AnyObject], completion: (response: Any) -> Void) {
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
        let uploadTask = session!.uploadTaskWithRequest(request, fromData: bodyData) {
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


