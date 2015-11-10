//
//  UserTests.swift
//  RWAuth
//
//  Created by Роман on 22.10.15.
//  Copyright © 2015 weezlabs. All rights reserved.
//

import XCTest
@testable import RWAuth

class UserTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
        NetworkManager.session = nil
    }
    
    // MARK: - Sign In Tests
    
    func testSignInWithValidData() {
        // Given
        let stubbedURL = AuthPath.scheme + "://" + AuthPath.host + AuthPath.signInPath
        let email = "test@example.com"
        let password = "test123"
        let requestBody: [String: AnyObject] = ["email": email, "password": password]
        let answerBody: [String: AnyObject] = ["access_token": "LHelF8mJxsub/+lSKhOjTaH", "refresh_token": "eG3xUsZ/GM3YmyQDVxVRfJekmial"]
        let statusCode = 200
        var result: Result<Any, NSError>?
        
        let mock = MockSession()
        NetworkManager.session = mock
        mock.stubRequest("POST", url: stubbedURL, requestBody: requestBody, returnCode: statusCode, answerBody: answerBody)
        let expectation = expectationWithDescription("request should be successful")
        
        // When
        User.signInWithEmail(email, password: password) { (innerResult) -> Void in
            result = innerResult
            expectation.fulfill()
        }
        waitForExpectationsWithTimeout(5, handler: nil)
        
        // Then
        guard let value = result?.value else {
            XCTFail("\(result?.error)")
            return
        }
        let user = value as! User
        XCTAssertEqual(user.email, email, "emails sould be equal")
        XCTAssertEqual(user.accessToken!, answerBody["access_token"] as? String, "accessTokens should be equal")
        XCTAssertEqual(user.refreshToken!, answerBody["refresh_token"] as? String, "refreshTokens should be equal")
    }
    
    func testSignInWithInvalidData() {
        // Given
        let stubbedURL = AuthPath.scheme + "://" + AuthPath.host + AuthPath.signInPath
        let email = "test@example.com"
        let password = "test123"
        let requestBody: [String: AnyObject] = ["email": email, "password": password]
        let answerBody: [String: AnyObject] = ["access_token": "LHelF8mJxsub/+lSKhOjTaH", "refresh_token": "eG3xUsZ/GM3YmyQDVxVRfJekmial"]
        let statusCode = 400
        var result: Result<Any, NSError>?
        
        let mock = MockSession()
        NetworkManager.session = mock
        mock.stubRequest("POST", url: stubbedURL, requestBody: requestBody, returnCode: statusCode, answerBody: answerBody)
        let expectation = expectationWithDescription("request should be successful")
        
        // When
        User.signInWithEmail(email, password: password) { (innerResult) -> Void in
            result = innerResult
            expectation.fulfill()
        }
        waitForExpectationsWithTimeout(5, handler: nil)
        
        // Then
        guard let error = result?.error else {
            XCTFail("should be error")
            return
        }
        XCTAssertEqual(error, AuthorizationError.ValidationError(statusCode).error, "errors sould be equal")
    }
    
    // MARK: - Sign Up Tests
    
    func testSignUpWithValidData() {
        // Given
        let stubbedURL = AuthPath.scheme + "://" + AuthPath.host + AuthPath.signUpPath
        let username = "wizard"
        let email = "test@example.com"
        let password = "test123"
        let requestBody: [String: AnyObject] = ["user_name": username, "password": password, "email": email]
        let answerBody: [String: AnyObject] = ["id": "1", "user_name": username, "email": email]
        let statusCode = 200
        var result: Result<Any, NSError>?
        
        let mock = MockSession()
        NetworkManager.session = mock
        mock.stubRequest("POST", url: stubbedURL, requestBody: requestBody, returnCode: statusCode, answerBody: answerBody)
        let expectation = expectationWithDescription("request should be successful")
        
        // When
        User.signUpWithUsername(username, password: password, email: email) { (innerResult) -> Void in
            result = innerResult
            expectation.fulfill()
        }
        waitForExpectationsWithTimeout(5, handler: nil)
        
        // Then
        guard let value = result?.value else {
            XCTFail("\(result?.error)")
            return
        }
        let user = value as! User
        XCTAssertEqual(user.email, email, "emails sould be equal")
        XCTAssertEqual(user.username, answerBody["user_name"] as? String, "usernames should be equal")
        XCTAssertEqual(user.id, answerBody["id"] as? Int, "ids should be equal")
    }
    
    func testSignUpWithInvalidData() {
        // Given
        let stubbedURL = AuthPath.scheme + "://" + AuthPath.host + AuthPath.signUpPath
        let username = "wizard"
        let email = "test@example.com"
        let password = "test123"
        let requestBody: [String: AnyObject] = ["user_name": username, "password": password, "email": email]
        let answerBody: [String: AnyObject] = ["AnyKey": "AnyValue"]
        let statusCode = 400
        var result: Result<Any, NSError>?
        
        let mock = MockSession()
        NetworkManager.session = mock
        mock.stubRequest("POST", url: stubbedURL, requestBody: requestBody, returnCode: statusCode, answerBody: answerBody)
        let expectation = expectationWithDescription("request should be successful")
        
        // When
        User.signUpWithUsername(username, password: password, email: email) { (innerResult) -> Void in
            result = innerResult
            expectation.fulfill()
        }
        waitForExpectationsWithTimeout(5, handler: nil)
        
        // Then
        guard let error = result?.error else {
            XCTFail("should be error")
            return
        }
        XCTAssertEqual(error, AuthorizationError.ValidationError(statusCode).error, "errors sould be equal")
    }
    
    // MARK: - Request Recovery Code Tests
    
    func testRequestRecoveryCodeForValidEmail() {
        // Given
        let stubbedURL = AuthPath.scheme + "://" + AuthPath.host + AuthPath.passwordRecoveryPath
        let email = "test@example.com"
        let requestBody: [String: AnyObject] = ["email": email]
        let answerBody: [String: AnyObject] = ["AnyKey": "AnyValue"]
        let statusCode = 200
        var result: Result<Any, NSError>?
        
        let mock = MockSession()
        NetworkManager.session = mock
        mock.stubRequest("POST", url: stubbedURL, requestBody: requestBody, returnCode: statusCode, answerBody: answerBody)
        let expectation = expectationWithDescription("request should be successful")
        
        // When
        User.requestRecoveryCodeForEmail(email) { (innerResult) -> Void in
            result = innerResult
            expectation.fulfill()
        }
        waitForExpectationsWithTimeout(5, handler: nil)
        
        // Then
        guard let value = result?.value else {
            XCTFail("\(result?.error)")
            return
        }
        let successString = value as! String
        XCTAssertEqual(successString, "Recovery code send on \(email)")
    }
    
    func testRequestRecoveryCodeInvalidEmail() {
        // Given
        let stubbedURL = AuthPath.scheme + "://" + AuthPath.host + AuthPath.passwordRecoveryPath
        let email = "test@example.com"
        let requestBody: [String: AnyObject] = ["email": email]
        let answerBody: [String: AnyObject] = ["AnyKey": "AnyValue"]
        let statusCode = 400
        var result: Result<Any, NSError>?
        
        let mock = MockSession()
        NetworkManager.session = mock
        mock.stubRequest("POST", url: stubbedURL, requestBody: requestBody, returnCode: statusCode, answerBody: answerBody)
        let expectation = expectationWithDescription("request should be successful")
        
        // When
        User.requestRecoveryCodeForEmail(email) { (innerResult) -> Void in
            result = innerResult
            expectation.fulfill()
        }
        waitForExpectationsWithTimeout(5, handler: nil)
        
        // Then
        guard let error = result?.error else {
            XCTFail("should be error")
            return
        }
        XCTAssertEqual(error, AuthorizationError.ValidationError(statusCode).error, "errors sould be equal")
    }
    
    func testRequestRecoveryCodeForNonexistingEmail() {
        // Given
        let stubbedURL = AuthPath.scheme + "://" + AuthPath.host + AuthPath.passwordRecoveryPath
        let email = "test@example.com"
        let requestBody: [String: AnyObject] = ["email": email]
        let answerBody: [String: AnyObject] = ["AnyKey": "AnyValue"]
        let statusCode = 404
        var result: Result<Any, NSError>?
        
        let mock = MockSession()
        NetworkManager.session = mock
        mock.stubRequest("POST", url: stubbedURL, requestBody: requestBody, returnCode: statusCode, answerBody: answerBody)
        let expectation = expectationWithDescription("request should be successful")
        
        // When
        User.requestRecoveryCodeForEmail(email) { (innerResult) -> Void in
            result = innerResult
            expectation.fulfill()
        }
        waitForExpectationsWithTimeout(5, handler: nil)
        
        // Then
        guard let error = result?.error else {
            XCTFail("should be error")
            return
        }
        XCTAssertEqual(error, AuthorizationError.UserWithEmailNotExist(statusCode).error, "errors should be equal")
    }
    
    // MARK: - Set New Password Tests
    
    func testSetNewPasswordWithValidCode() {
        // Given
        let stubbedURL = AuthPath.scheme + "://" + AuthPath.host + AuthPath.passwordRecoveryPath
        let password = "password"
        let passwordConfirmation = "password"
        let recoveryCode = "ALKJSD"
        let requestBody: [String: AnyObject] = ["password": password, "password_confirmation": passwordConfirmation, "code": recoveryCode]
        let answerBody: [String: AnyObject] = ["AnyKey": "AnyValue"]
        let statusCode = 200
        var result: Result<Any, NSError>?
        
        let mock = MockSession()
        NetworkManager.session = mock
        mock.stubRequest("PUT", url: stubbedURL, requestBody: requestBody, returnCode: statusCode, answerBody: answerBody)
        let expectation = expectationWithDescription("request should be successful")
        
        // When
        User.setNewPassword(password, passwordConfimation: passwordConfirmation, recoveryCode: recoveryCode) { (innerResult) -> Void in
            result = innerResult
            expectation.fulfill()
        }
        waitForExpectationsWithTimeout(5, handler: nil)
        
        // Then
        guard let value = result?.value else {
            XCTFail("\(result?.error)")
            return
        }
        XCTAssertEqual(value as? String, "New password setted")
    }
    
    func testSetNewPasswordWithIncorrectCode() {
        // Given
        let stubbedURL = AuthPath.scheme + "://" + AuthPath.host + AuthPath.passwordRecoveryPath
        let password = "password"
        let passwordConfirmation = "password"
        let recoveryCode = "ALKJSD"
        let requestBody: [String: AnyObject] = ["password": password, "password_confirmation": passwordConfirmation, "code": recoveryCode]
        let answerBody: [String: AnyObject] = ["AnyKey": "AnyValue"]
        let statusCode = 404
        var result: Result<Any, NSError>?
        
        let mock = MockSession()
        NetworkManager.session = mock
        mock.stubRequest("PUT", url: stubbedURL, requestBody: requestBody, returnCode: statusCode, answerBody: answerBody)
        let expectation = expectationWithDescription("request should be successful")
        
        // When
        User.setNewPassword(password, passwordConfimation: passwordConfirmation, recoveryCode: recoveryCode) { (innerResult) -> Void in
            result = innerResult
            expectation.fulfill()
        }
        waitForExpectationsWithTimeout(5, handler: nil)
        
        // Then
        guard let error = result?.error else {
            XCTFail("should be error")
            return
        }
        XCTAssertEqual(error, AuthorizationError.IncorrectRecoverCode(statusCode).error, "errors should be equal")
    }
    
    func testSetNewPasswordWithInvalidData() {
        // Given
        let stubbedURL = AuthPath.scheme + "://" + AuthPath.host + AuthPath.passwordRecoveryPath
        let password = "password"
        let passwordConfirmation = "password234"
        let recoveryCode = "ALKJSD"
        let requestBody: [String: AnyObject] = ["password": password, "password_confirmation": passwordConfirmation, "code": recoveryCode]
        let answerBody: [String: AnyObject] = ["AnyKey": "AnyValue"]
        let statusCode = 400
        var result: Result<Any, NSError>?
        
        let mock = MockSession()
        NetworkManager.session = mock
        mock.stubRequest("PUT", url: stubbedURL, requestBody: requestBody, returnCode: statusCode, answerBody: answerBody)
        let expectation = expectationWithDescription("request should be successful")
        
        // When
        User.setNewPassword(password, passwordConfimation: passwordConfirmation, recoveryCode: recoveryCode) { (innerResult) -> Void in
            result = innerResult
            expectation.fulfill()
        }
        waitForExpectationsWithTimeout(5, handler: nil)
        
        // Then
        guard let error = result?.error else {
            XCTFail("should be error")
            return
        }
        XCTAssertEqual(error, AuthorizationError.ValidationError(statusCode).error, "errors should be equal")
    }
    
    // MARK: - Refresh Tokens Tests
    
    func testRefreshtokenWithValidData() {
        // Given
        let stubbedURL = AuthPath.scheme + "://" + AuthPath.host + AuthPath.refreshTokenPath
        let refreshToken = "eG3xUsZ/GM3YmyQDVxVRfJekmial"
        let requestBody: [String: AnyObject] = ["refresh_token": refreshToken]
        let answerBody: [String: AnyObject] = ["access_token": "LHelF8mJxsub/+lSKhOjTaH", "refresh_token": "eG3xUsZ/GM3YmyQDVxVRfJekmial"]
        let statusCode = 200
        var result: Result<Any, NSError>?
        
        let mock = MockSession()
        NetworkManager.session = mock
        mock.stubRequest("PUT", url: stubbedURL, requestBody: requestBody, returnCode: statusCode, answerBody: answerBody)
        let expectation = expectationWithDescription("request should be successful")
        
        // When
        User.refreshTokensWithToken(refreshToken) { (innerResult) -> Void in
            result = innerResult
            expectation.fulfill()
        }
        waitForExpectationsWithTimeout(5, handler: nil)
        
        // Then
        guard let value = result?.value else {
            XCTFail("\(result?.error)")
            return
        }
        let user = value as! User
        XCTAssertEqual(user.accessToken!, answerBody["access_token"] as? String, "accessTokens should be equal")
        XCTAssertEqual(user.refreshToken!, answerBody["refresh_token"] as? String, "refreshTokens should be equal")
    }
    
    func testRefreshTokenWithInvalidData() {
        // Given
        let stubbedURL = AuthPath.scheme + "://" + AuthPath.host + AuthPath.refreshTokenPath
        let refreshToken = "eG3xUsZ/GM3YmyQDVxVRfJekmial"
        let requestBody: [String: AnyObject] = ["refresh_token": refreshToken]
        let answerBody: [String: AnyObject] = ["access_token": "LHelF8mJxsub/+lSKhOjTaH", "refresh_token": "eG3xUsZ/GM3YmyQDVxVRfJekmial"]
        let statusCode = 400
        var result: Result<Any, NSError>?
        
        let mock = MockSession()
        NetworkManager.session = mock
        mock.stubRequest("PUT", url: stubbedURL, requestBody: requestBody, returnCode: statusCode, answerBody: answerBody)
        let expectation = expectationWithDescription("request should be successful")
        
        // When
        User.refreshTokensWithToken(refreshToken) { (innerResult) -> Void in
            result = innerResult
            expectation.fulfill()
        }
        waitForExpectationsWithTimeout(5, handler: nil)
        
        // Then
        guard let error = result?.error else {
            XCTFail("should be error")
            return
        }
        XCTAssertEqual(error, AuthorizationError.ValidationError(statusCode).error, "errors sould be equal")
    }
    
    // MARK: - Check Email Tests
    
    func testCheckEmailWithValidNonexistingEmail() {
        // Given
        let stubbedURL = AuthPath.scheme + "://" + AuthPath.host + AuthPath.checkEmail
        let email = "test@example.com"
        let requestBody: [String: AnyObject] = ["email": email]
        let answerBody: [String: AnyObject] = ["AnyKey": "AnyValue"]
        let statusCode = 200
        var result: Result<Any, NSError>?
        
        let mock = MockSession()
        NetworkManager.session = mock
        mock.stubRequest("POST", url: stubbedURL, requestBody: requestBody, returnCode: statusCode, answerBody: answerBody)
        let expectation = expectationWithDescription("request should be successful")
        
        // When
        User.checkEmail(email) { (innerResult) -> Void in
            result = innerResult
            expectation.fulfill()
        }
        waitForExpectationsWithTimeout(5, handler: nil)
        
        // Then
        guard let value = result?.value else {
            XCTFail("\(result?.error)")
            return
        }
        XCTAssertEqual(value as? String, "Email doesn't exist", "result.value should be equal 'email doesn't exist'")
    }
    
    func testCheckEmailWithValidExistingEmail() {
        // Given
        let stubbedURL = AuthPath.scheme + "://" + AuthPath.host + AuthPath.checkEmail
        let email = "test@example.com"
        let requestBody: [String: AnyObject] = ["email": email]
        let answerBody: [String: AnyObject] = ["AnyKey": "AnyValue"]
        let statusCode = 409
        var result: Result<Any, NSError>?
        
        let mock = MockSession()
        NetworkManager.session = mock
        mock.stubRequest("POST", url: stubbedURL, requestBody: requestBody, returnCode: statusCode, answerBody: answerBody)
        let expectation = expectationWithDescription("request should be successful")
        
        // When
        User.checkEmail(email) { (innerResult) -> Void in
            result = innerResult
            expectation.fulfill()
        }
        waitForExpectationsWithTimeout(5, handler: nil)
        
        // Then
        guard let error = result?.error else {
            XCTFail("should be error")
            return
        }
        XCTAssertEqual(error, AuthorizationError.UserAlreadyExist(statusCode).error, "errors sould be equal")
    }
    
    func testCheckEmailWithInvalidEmail() {
        // Given
        let stubbedURL = AuthPath.scheme + "://" + AuthPath.host + AuthPath.checkEmail
        let email = "example.com"
        let requestBody: [String: AnyObject] = ["email": email]
        let answerBody: [String: AnyObject] = ["AnyKey": "AnyValue"]
        let statusCode = 400
        var result: Result<Any, NSError>?
        
        let mock = MockSession()
        NetworkManager.session = mock
        mock.stubRequest("POST", url: stubbedURL, requestBody: requestBody, returnCode: statusCode, answerBody: answerBody)
        let expectation = expectationWithDescription("request should be successful")
        
        // When
        User.checkEmail(email) { (innerResult) -> Void in
            result = innerResult
            expectation.fulfill()
        }
        waitForExpectationsWithTimeout(5, handler: nil)
        
        // Then
        guard let error = result?.error else {
            XCTFail("should be error")
            return
        }
        XCTAssertEqual(error, AuthorizationError.ValidationError(statusCode).error, "errors sould be equal")
    }
    
}
