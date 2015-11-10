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
    case UserWithEmailNotExist (Int)
    case IncorrectRecoverCode (Int)
    
    var error: NSError {
        switch self {
        case .ValidationError(let code):
            return NSError(domain: kCFErrorDomainCFNetwork as String, code: code, userInfo: [NSLocalizedDescriptionKey: "Validation Error"])
        case .UserAlreadyExist(let code):
            return NSError(domain: kCFErrorDomainCFNetwork as String, code: code, userInfo: [NSLocalizedDescriptionKey: "User Already Exist"])
        case .UserWithEmailNotExist(let code):
            return NSError(domain: kCFErrorDomainCFNetwork as String, code: code, userInfo: [NSLocalizedDescriptionKey: "Could Not Find User With Email"])
        case .IncorrectRecoverCode( let code):
            return NSError(domain: kCFErrorDomainCFNetwork as String, code: code, userInfo: [NSLocalizedDescriptionKey: "Incorrect Recover Code"])
        }
    }
}
