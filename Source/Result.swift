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
}
