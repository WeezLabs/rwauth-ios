//
//  AuthorizationError.swift
//  RWAuth
//
//  Created by Роман on 15.10.15.
//  Copyright © 2015 weezlabs. All rights reserved.
//

import Foundation

public enum AuthorizationError: ErrorType{
    case IncorrectEmail
    case IncorrectUserName
    case IncorrectPassword
    case IncorrectToken
    case IncorrectRecoverCode
}
