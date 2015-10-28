//
//  MockSession.swift
//  RWAuth
//
//  Created by Роман on 28.10.15.
//  Copyright © 2015 weezlabs. All rights reserved.
//

import Foundation

class MockSession: NSURLSession {
//    var fakeRequest?
//    var fakeAnswer?
    
    func stubRequest(method: String, url: String) -> Self{
        return self
    }
    
    func withRequestBody(body: String) -> Self{
        return self
    }
    
    func andReturnCode(code: Int) -> Self {
        return self
    }
    
    func withAnswerBody(body: String) -> Self {
        return self
    }
    
    override func uploadTaskWithRequest(request: NSURLRequest, fromData bodyData: NSData?, completionHandler: (NSData?, NSURLResponse?, NSError?) -> Void) -> NSURLSessionUploadTask {
        let sessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: sessionConfiguration)
        
        let uploadTask = session.uploadTaskWithRequest(request, fromData: bodyData) { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            let dict = try? NSJSONSerialization.JSONObjectWithData(bodyData!, options: NSJSONReadingOptions(rawValue: 0))
            
            
            completionHandler(data, response, error)
        }
        return uploadTask
    }
}
