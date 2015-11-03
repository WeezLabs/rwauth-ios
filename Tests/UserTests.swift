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
    }
    
    // MARK: - Sign In Tests
    
    func testSignInWithValidData() {
        // Given
        let stubbedURL = NetworkManager.scheme + "://" + NetworkManager.host + AuthPath.signInPath.rawValue
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
        let stubbedURL = NetworkManager.scheme + "://" + NetworkManager.host + AuthPath.signInPath.rawValue
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
        XCTAssertEqual(error.localizedDescription, "Validation error", "error should be equal 'Validation error'")
    }
    
    // MARK: - Check Email Tests
    
    func testCheckEmailWithValidNonexistingEmail() {
        // Given
        let stubbedURL = NetworkManager.scheme + "://" + NetworkManager.host + AuthPath.checkEmail.rawValue
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
        let stubbedURL = NetworkManager.scheme + "://" + NetworkManager.host + AuthPath.checkEmail.rawValue
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
        XCTAssertEqual(error.localizedDescription, "User with such email exists", "error should be equal 'User with such email exists'")
    }
    
    func testCheckEmailWithInvalidEmail() {
        // Given
        let stubbedURL = NetworkManager.scheme + "://" + NetworkManager.host + AuthPath.checkEmail.rawValue
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
        XCTAssertEqual(error.localizedDescription, "Validation error", "error should be equal 'Validation error'")
    }
}
