//
//  FakeAnswer.swift
//  RWAuth
//
//  Created by Роман on 28.10.15.
//  Copyright © 2015 weezlabs. All rights reserved.
//

import Foundation

struct FakeAnswer {
    var answerCode: Int
    var answerBody: [String: Any]
    
    init(code: Int, body: [String: Any]) {
        answerCode = code
        answerBody = body
    }
}