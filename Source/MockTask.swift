//
//  MockTask.swift
//  RWAuth
//
//  Created by Роман on 29.10.15.
//  Copyright © 2015 weezlabs. All rights reserved.
//

import Foundation

class MockTask: NSURLSessionUploadTask {
    let completionHandler: (() -> Void)
    
    init(completion: () -> Void) {
        self.completionHandler = completion
    }
    
    override func resume() {
        completionHandler()
    }
}
