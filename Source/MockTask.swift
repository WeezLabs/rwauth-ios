//
//  MockTask.swift
//  RWAuth
//
//  Created by Роман on 29.10.15.
//  Copyright © 2015 weezlabs. All rights reserved.
//

import Foundation

class MockTask: NSURLSessionUploadTask {
    var mockResponse: (data: NSData?, urlResponse: NSURLResponse?, error: NSError?)
    let completionHandler: ((NSData?, NSURLResponse?, NSError?) -> Void)
    
//    init(data: NSData?, urlResponse: NSURLResponse?, error: NSError?, completionHandler: ((NSData!, NSURLResponse!, NSError!) -> Void)?) {
//        self.mockResponse = (data, urlResponse, error)
//        self.completionHandler = completionHandler
//    }
    
    init(completion: (data: NSData?, urlResponse: NSURLResponse?, error: NSError?) -> Void) {
        self.completionHandler = completion
    }
    
//    override func resume() {
//        completionHandler!(mockResponse.data, mockResponse.urlResponse, mockResponse.error)
//    }
    
    override func resume() {
        completionHandler(nil, nil, nil)
    }
}
