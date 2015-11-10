//
//  AuthPath.swift
//  RWAuth
//
//  Created by Роман on 22.10.15.
//  Copyright © 2015 weezlabs. All rights reserved.
//

import Foundation

struct AuthPath {
    static var signUpPath = "/users/signup"
    static var signInPath = "/users/signin"
    static var signOutPath = "/users/signout"
    static var passwordRecoveryPath = "/users/password_recovery"
    static var refreshTokenPath = "/users/accesstoken/refresh"
    static var checkEmail = "/users/check_email"
    
    static var scheme = "http"
    static var host = "exampledomain.com"
}
