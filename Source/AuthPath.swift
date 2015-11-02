//
//  AuthPath.swift
//  RWAuth
//
//  Created by Роман on 22.10.15.
//  Copyright © 2015 weezlabs. All rights reserved.
//

import Foundation

enum AuthPath: String{
    case signUpPath = "/users/signup"
    case signInPath = "/users/signin"
    case signOutPath = "/users/signout"
    case passwordRecoveryPath = "/users/password_recovery"
    case refreshTokenPath = "/users/accesstoken/refresh"
    case checkEmail = "/users/check_email"
}
