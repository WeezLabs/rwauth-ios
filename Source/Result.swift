//
//  Result.swift
//  RWAuth
//
//  Created by Роман on 23.10.15.
//  Copyright © 2015 weezlabs. All rights reserved.
//

import Foundation

public enum Result<Value, Error: ErrorType> {
    case Success (Value)
    case Failure (Error)
    
    public var isSuccess: Bool {
        switch self {
        case .Success:
            return true
        case .Failure:
            return false
        }
    }
    
    public var isFailure: Bool {
        return !isSuccess
    }
    
    public var value: Value? {
        switch self {
        case .Success(let value):
            return value
        case .Failure:
            return nil
        }
    }

    public var error: Error? {
        switch self {
        case .Success:
            return nil
        case .Failure(let error):
            return error
        }
    }
}
