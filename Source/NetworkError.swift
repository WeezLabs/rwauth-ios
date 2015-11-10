//
//  NetworkError.swift
//  RWAuth
//
//  Created by Роман on 26.10.15.
//  Copyright © 2015 weezlabs. All rights reserved.
//

import Foundation

enum NetworkError: ErrorType {
    case InvalidURL
    case SerializationError
    case EmptyResponseOrData
    case ClientError (Int)
    case ServerError (Int)
    
    static var domain = "com.weezlabs.rwauth.network"
    
    var error: NSError {
        switch self {
        case .InvalidURL:
            return NSError(domain: NetworkError.domain as String, code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
        case .SerializationError:
            return NSError(domain: NetworkError.domain as String, code: 1, userInfo: [NSLocalizedDescriptionKey: "Serialization Error"])
        case .ClientError(let code):
                return NSError(domain: kCFErrorDomainCFNetwork as String, code: code, userInfo: [NSLocalizedDescriptionKey: "Client Error"])
        case .ServerError(let code):
            return NSError(domain: kCFErrorDomainCFNetwork as String, code: code, userInfo: [NSLocalizedDescriptionKey: "Server Error"])
        case .EmptyResponseOrData:
            return NSError(domain: NetworkError.domain as String, code: 2, userInfo: [NSLocalizedDescriptionKey: "Empty Response or Data"])
        }
    }
}
