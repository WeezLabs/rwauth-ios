//
//  Response.swift
//  RWAuth
//
//  Created by Роман on 23.10.15.
//  Copyright © 2015 weezlabs. All rights reserved.
//

import Foundation

public struct Response<Value, Error: ErrorType> {
    public var request: NSMutableURLRequest?
    public var response: NSURLResponse?
    public var data: NSData?
    public var result: Result<Value, Error>?
    
    public init(request: NSMutableURLRequest?, response:NSURLResponse?, data: NSData?, result: Result<Value, Error>?){
        self.request = request
        self.response = response
        self.data = data
        self.result = result
    }
    
    public init(){
        
    }
}


