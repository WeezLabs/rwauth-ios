//
//  MockSessionError.swift
//  RWAuth
//
//  Created by Роман on 03.11.15.
//  Copyright © 2015 weezlabs. All rights reserved.
//

import Foundation

enum MockSessionError: Int, ErrorType {
    case UnrecognizedError = 0
    case FakeRequestOrFakeAnswerNotSetted = 1
    case EmptyBodyData = 2
    case BodyDataNotConvertableToString = 3
    case RequestDoesNotHaveURL = 4
    case StubbedURLNotEqualRequestURL = 5
    case StubbedRequestBodyNotEqualRequestBody = 6
    
    static var domain: String = "com.weezlabs.httpmock.session"
    
    var error: NSError {
        switch self {
        case .UnrecognizedError:
            return NSError(domain: MockSessionError.domain, code: self.rawValue, userInfo: [NSLocalizedDescriptionKey: "Unrecognized Error"])
            
        case .FakeRequestOrFakeAnswerNotSetted:
            return NSError(domain: MockSessionError.domain, code: self.rawValue, userInfo: [NSLocalizedDescriptionKey: "Fake Request Or Fake Answer Not Setted"])
        case .EmptyBodyData:
            return NSError(domain: MockSessionError.domain, code: self.rawValue, userInfo: [NSLocalizedDescriptionKey: "Empty Body Data"])
        case .BodyDataNotConvertableToString:
            return NSError(domain: MockSessionError.domain, code: self.rawValue, userInfo: [NSLocalizedDescriptionKey: "Body Data Not Convertable To String"])
        case .RequestDoesNotHaveURL:
            return NSError(domain: MockSessionError.domain, code: self.rawValue, userInfo: [NSLocalizedDescriptionKey: "Request Does Not have URL"])
        case .StubbedURLNotEqualRequestURL:
            return NSError(domain: MockSessionError.domain, code: self.rawValue, userInfo: [NSLocalizedDescriptionKey: "Stubbed URL Not Equal Request URL"])
        case .StubbedRequestBodyNotEqualRequestBody:
            return NSError(domain: MockSessionError.domain, code: self.rawValue, userInfo: [NSLocalizedDescriptionKey: "Stubbed Request Body Not Equal Request Body"])
        }
    }
}
