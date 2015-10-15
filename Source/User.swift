//
//  User.swift
//  RWAuth
//
//  Created by Роман on 15.10.15.
//  Copyright © 2015 weezlabs. All rights reserved.
//

import Foundation

public class User: NSObject {
    public var username: String?
    public var email: String?
    private(set) public var accessToken: String?
    private(set) public var refreshToken: String?
    private(set) public var accessTokenExpirationDate: NSDate?
    
    
    class func signInWithUsername(username: String, password: String, isAsync: Bool, completionHandler: (user: User) throws -> Void){
        
    }
    
    class func signUpWithUsername(username:String, pasword: String, email: String, isAsync: Bool, completion: (user: User) throws -> Void){
        
    }
    
    class func signOut(isAsync: Bool, completionHandler: () throws -> Void){
        
    }
    
    class func requestRecoveryCodeForEmail(email: String, isAsync:Bool, completionHandler:() throws -> Void){
        
    }
    
    class func setNewPassword(password: String, recoveryCode: String, isAsync: Bool, completion: () throws -> Void){
        
    }
    
    class func refreshTokensWithToken(refreshToken: String, isAsynch: Bool, completion: () throws -> Void){
        
    }
}