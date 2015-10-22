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
    
    let session: NSURLSession
    
    override init() {
        let sessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
        self.session = NSURLSession(configuration: sessionConfiguration)
    }
    
    class func request(method: HTTPMethod, path: AuthPath, body: [String: String], completion:(response: NSData?, error: NSError?) -> Void) {
        
        let session = NetworkManager.sharedManager.session
        guard let url = NSURL(scheme: scheme, host: host, path: path.rawValue) else {return}
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = method.rawValue
        
        let bodyData = try? NSJSONSerialization.dataWithJSONObject(body, options: NSJSONWritingOptions(rawValue: 0))
        
        let uploadTask = session.uploadTaskWithRequest(request, fromData: bodyData) { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            completion(response: data, error: error)
        }
        uploadTask.resume()
    }
}

enum HTTPMethod: String {
    case POST = "POST"
    case PUT = "PUT"
}
