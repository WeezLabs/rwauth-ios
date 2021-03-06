//
//  NetworkManager.swift
//  RWAuth
//
//  Created by Роман on 22.10.15.
//  Copyright © 2015 weezlabs. All rights reserved.
//

import Foundation

class NetworkManager: NSObject {
    
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
    
    class func request(method: HTTPMethod, authPath: String, body: [String: AnyObject], isAsync: Bool = true, completion: (response: Response<Any, NSError>) -> Void) {
        
        var semaphore: dispatch_semaphore_t?
        if !isAsync {
            semaphore = dispatch_semaphore_create(0)
        }
        
        var response = Response<Any, NSError>()
        guard let url = NSURL(scheme: AuthPath.scheme, host: AuthPath.host, path: authPath) else {
            let result = Result<Any, NSError>.Failure(NetworkError.InvalidURL.error)
            response.result = result
            completion(response: response)
            return
        }
        
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = method.rawValue
        response.request = request
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        let bodyData = try? NSJSONSerialization.dataWithJSONObject(body, options: NSJSONWritingOptions(rawValue: 0))
        
        let uploadTask = configureUploadTask(request, bodyData: bodyData) {response in
            completion(response: response)
            if semaphore != nil {
                dispatch_semaphore_signal(semaphore!)
            }
        }
        
        uploadTask.resume()
        
        if semaphore != nil {
            dispatch_semaphore_wait(semaphore!, DISPATCH_TIME_FOREVER)
        }
    }
    
    private class func configureUploadTask(request: NSMutableURLRequest, bodyData: NSData?, completion: (response: Response<Any, NSError>) -> Void) -> NSURLSessionUploadTask {
        return session!.uploadTaskWithRequest(request, fromData: bodyData) {
            (innerData: NSData?, innerResponse: NSURLResponse?, error: NSError?) -> Void in
            let result: Result<Any, NSError>
            
            if let error = error {
                result = Result.Failure(error)
            } else if innerData == nil || innerResponse == nil {
                result = Result.Failure(NetworkError.EmptyResponseOrData.error)
            } else {
                if let successDict = try? NSJSONSerialization.JSONObjectWithData(innerData!, options: NSJSONReadingOptions(rawValue: 0)) {
                    let httpResponse = innerResponse as! NSHTTPURLResponse
                    if httpResponse.statusCode >= 400 && httpResponse.statusCode < 500 {
                        result = Result.Failure(NetworkError.ClientError(httpResponse.statusCode).error)
                        
                    } else if httpResponse.statusCode >= 500 && httpResponse.statusCode < 600 {
                        result = Result.Failure(NetworkError.ServerError(httpResponse.statusCode).error)
                    } else {
                        result = Result.Success(successDict)
                    }
                } else {
                    result = Result.Failure(NetworkError.SerializationError.error)
                }
            }
            let response = Response(request: request, response: innerResponse, data: innerData, result: result)
            completion(response: response)
        }
    }
}


