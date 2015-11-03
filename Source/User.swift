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
    public var id: Int?
    private(set) public var accessToken: String?
    private(set) public var refreshToken: String?
    private(set) public var accessTokenExpirationDate: NSDate?
    
    
    public class func signInWithEmail(email: String, password: String, isAsync: Bool = true, completion: (result: Result<Any, NSError>) -> Void) {
        let requestBody = ["email": email, "password": password]
        NetworkManager.request(.POST, path: .signInPath, body: requestBody) { response in
            if (response.result?.isSuccess == true) {
                let user = User()
                user.email = email
                guard let responseDict = response.result?.value else { return }
                let newDict = responseDict as! NSDictionary
                user.accessToken = newDict["access_token"] as? String
                user.refreshToken = newDict["refresh_token"] as? String
                
                let result = Result<Any, NSError>.Success(user)
                completion(result: result)
                
            } else if response.response?.statusCode == 400 {
                let result = Result<Any, NSError>.Failure(AuthorizationError.ValidationError(400).error)
                completion(result: result)
            } else {
                completion(result: response.result!)
            }
        }
    }
    
    public class func signUpWithUsername(username:String, password: String, email: String, isAsync: Bool = true, completion: (result: Result<Any, NSError>) -> Void) {
        let requestBody = ["user_name": username, "password": password, "email": email]
        NetworkManager.request(.POST, path: .signUpPath, body: requestBody) { response in
            if (response.result?.isSuccess == true) {
                let user = User()
                user.email = email
                guard let responseDict = response.result?.value else { return }
                let newDict = responseDict as! NSDictionary
                user.id = newDict["id"] as? Int
                user.username = newDict["user_name"] as? String
                user.email = newDict["email"] as? String
                
                let result = Result<Any, NSError>.Success(user)
                completion(result: result)
                
            } else if response.response?.statusCode == 400 {
                let result = Result<Any, NSError>.Failure(AuthorizationError.ValidationError(400).error)
                completion(result: result)
            } else {
                completion(result: response.result!)
            }
        }
    }
    
    public class func signOut(isAsync: Bool = true, completion: (error: NSError?) -> Void) {
        
    }
    
    public class func requestRecoveryCodeForEmail(email: String, isAsync:Bool = true, completion:(result: Result<Any, NSError>) -> Void) {
        let requestBody = ["email": email]
        NetworkManager.request(.POST, path: .passwordRecoveryPath, body: requestBody) { response in
            if (response.result?.isSuccess == true) {
                let result = Result<Any, NSError>.Success("Recovery code send on \(email)")
                completion(result: result)
            } else if response.response?.statusCode == 400 {
                let result = Result<Any, NSError>.Failure(AuthorizationError.ValidationError(400).error)
                completion(result: result)
            } else if response.response?.statusCode == 404 {
                let result = Result<Any, NSError>.Failure(AuthorizationError.CouldNotFindUserWithEmail(404).error)
                completion(result: result)
            } else {
                completion(result: response.result!)
            }
        }
    }
    
    public class func setNewPassword(password: String, recoveryCode: String, isAsync: Bool = true, completion: (error: NSError?) -> Void) {
        
    }
    
    public class func refreshTokensWithToken(refreshToken: String, isAsynch: Bool = true, completion: (error: NSError?) -> Void){
        
    }
    
    public class func checkEmail(email: String, isAsync: Bool = true, completion: (result: Result<Any, NSError>) -> Void){
        NetworkManager.request(.POST, path: .checkEmail, body: ["email": email]) { response in
            if (response.result?.isSuccess == true) {
                let result = Result<Any, NSError>.Success("Email doesn't exist")
                completion(result: result)
            } else if response.response?.statusCode == 409 {
                let result = Result<Any, NSError>.Failure(AuthorizationError.UserAlreadyExist(409).error)
                completion(result: result)
            } else if response.response?.statusCode == 400 {
                let result = Result<Any, NSError>.Failure(AuthorizationError.ValidationError(400).error)
                completion(result: result)
            } else {
                completion(result: response.result!)
            }
        }
    }
}