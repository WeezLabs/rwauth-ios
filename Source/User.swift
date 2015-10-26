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
    
    
    public class func signInWithUsername(username: String, password: String, isAsync: Bool, completion: (user: User, error: NSError?) -> Void){
        
    }
    
    public class func signUpWithUsername(username:String, pasword: String, email: String, isAsync: Bool, completion: (user: User, error: NSError?) -> Void){
        
    }
    
    public class func signOut(isAsync: Bool, completion: (error: NSError?) -> Void){
        
    }
    
    public class func requestRecoveryCodeForEmail(email: String, isAsync:Bool, completion:(error: NSError?) -> Void){
        
    }
    
    public class func setNewPassword(password: String, recoveryCode: String, isAsync: Bool, completion: (error: NSError?) -> Void){
        
    }
    
    public class func refreshTokensWithToken(refreshToken: String, isAsynch: Bool, completion: (error: NSError?) -> Void){
        
    }
    
    public class func checkEmail(email: String, isAsync : Bool, complition: (error: NSError?) -> Void){
    
    }
    
}