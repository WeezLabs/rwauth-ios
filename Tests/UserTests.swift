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
    
    func testCheckEmailWithValidNonexistingEmail() {
        // Given
        let stubbedURL = "http://exampledomain.com" + AuthPath.checkEmail.rawValue
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
            XCTFail("should be value")
            return
        }
        XCTAssertEqual(value as? String, "Email doesn't exist", "result.value should be equal 'email doesn't exist'")
    }
    
    func testCheckEmailWithValidExistingEmail() {
        // Given
        let stubbedURL = "http://exampledomain.com" + AuthPath.checkEmail.rawValue
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
            XCTFail("should be value")
            return
        }
        XCTAssertEqual(error.localizedDescription, "User with such email exists", "error should be equal 'User with such email exists'")
    }
    
    func testCheckEmailWithInvalidEmail() {
        // Given
        let stubbedURL = "http://exampledomain.com" + AuthPath.checkEmail.rawValue
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
            XCTFail("should be value")
            return
        }
        XCTAssertEqual(error.localizedDescription, "Validation error", "error should be equal 'Validation error'")
    }
}
