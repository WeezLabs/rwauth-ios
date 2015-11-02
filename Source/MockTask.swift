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
    
    init(completion: (data: NSData?, urlResponse: NSURLResponse?, error: NSError?) -> Void) {
        self.completionHandler = completion
    }
    
    override func resume() {
        completionHandler(nil, nil, nil)
    }
}
