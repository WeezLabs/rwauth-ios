//
//  AuthPath.swift
//  RWAuth
//
//  Created by Роман on 22.10.15.
//  Copyright © 2015 weezlabs. All rights reserved.
//

import Foundation

struct AuthPath {
    static var signUp = "/users/signup"
    static var signIn = "/users/signin"
    static var signOut = "/users/signout"
    static var passwordRecovery = "/users/password_recovery"
    static var refreshToken = "/users/accesstoken/refresh"
    static var checkEmail = "/users/check_email"
    
    static var scheme = "http"
    static var host = "exampledomain.com"
}
