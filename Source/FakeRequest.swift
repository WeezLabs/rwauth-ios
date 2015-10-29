//
//  FakeRequest.swift
//  RWAuth
//
//  Created by Роман on 28.10.15.
//  Copyright © 2015 weezlabs. All rights reserved.
//

import Foundation

struct FakeRequest {
    var requestMethod: String
    var requestURL: String
    var requestBody: [String: Any]
    
    init(method: String, url: String, body: [String: Any]) {
        requestMethod = method
        requestURL = url
        requestBody = body
    }
}