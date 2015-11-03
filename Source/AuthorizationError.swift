//
//  AuthorizationError.swift
//  RWAuth
//
//  Created by Роман on 15.10.15.
//  Copyright © 2015 weezlabs. All rights reserved.
//

import Foundation

public enum AuthorizationError: ErrorType {
    case ValidationError (Int)
    case UserAlreadyExist (Int)
    
    var error: NSError {
        switch self {
        case .ValidationError(let code):
            return NSError(domain: kCFErrorDomainCFNetwork as String, code: code, userInfo: [NSLocalizedDescriptionKey: "Validation Error"])
        case .UserAlreadyExist(let code):
            return NSError(domain: kCFErrorDomainCFNetwork as String, code: code, userInfo: [NSLocalizedDescriptionKey: "User Already Exist"])
        }
    }
    
//    case IncorrectEmail
//    case IncorrectUserName
//    case IncorrectPassword
//    case IncorrectToken
//    case IncorrectRecoverCode
}
