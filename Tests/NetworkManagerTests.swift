//
//  NetworkManagerTests.swift
//  RWAuth
//
//  Created by Роман on 22.10.15.
//  Copyright © 2015 weezlabs. All rights reserved.
//

import XCTest
@testable import RWAuth

class NetworkManagerTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSuccessfulPOST() {
        // Given
        let stubbedURL = NetworkManager.scheme + "://" + NetworkManager.host + AuthPath.signInPath.rawValue
        let requestBody: [String: AnyObject] = ["user": "name"]
        let answerBody: [String: AnyObject] = ["status": "OK"]
        let statusCode = 200
        var response: Response<Any, NSError>?
        
        let mock = MockSession()
        NetworkManager.session = mock
        mock.stubRequest("POST", url: stubbedURL, requestBody: requestBody, returnCode: statusCode, answerBody: answerBody)
        let expectation = expectationWithDescription("request should be successful")
        
        // When
        NetworkManager.request(.POST, path: .signInPath, body: ["user": "name"]) { closureResponse in
            response = closureResponse
            expectation.fulfill()
        }
        waitForExpectationsWithTimeout(5, handler: nil)
        
        // Then
        if let response = response {
            XCTAssertNotNil(response.request, "request should not be nil")
            XCTAssertNotNil(response.response, "response should not be nil")
            XCTAssertEqual(response.response?.URL?.absoluteString, stubbedURL, "response url should be equal stubbedURL")
            XCTAssertNotNil(response.data, "data should not be nil")
            XCTAssertEqual(response.response?.statusCode, statusCode, "request should be success")
            XCTAssertTrue(response.result!.isSuccess, "result should be success")
            
            guard let value = response.result!.value else {
                XCTFail("\(response.result?.error)")
                return
            }
            XCTAssertEqual(value as? NSDictionary, answerBody as NSDictionary, "Should be equal")
        } else {
            XCTFail("response should not be nil")
        }
    }
    
    func testFailedPOST() {
        // Given
        let stubbedURL = NetworkManager.scheme + "://" + NetworkManager.host + AuthPath.signInPath.rawValue
        print("\(stubbedURL)")
        let requestBody: [String: AnyObject] = ["user": "name"]
        let answerBody: [String: AnyObject] = ["AnyKey": "AnyValue"]
        let statusCode = 400
        var response: Response<Any, NSError>?
        
        let mock = MockSession()
        NetworkManager.session = mock
        mock.stubRequest("POST", url: stubbedURL, requestBody: requestBody, returnCode: statusCode, answerBody: answerBody)
        let expectation = expectationWithDescription("request should be successful")
        
        // When
        NetworkManager.request(.POST, path: .signInPath, body: ["user": "name"]) { closureResponse in
            response = closureResponse
            expectation.fulfill()
        }
        waitForExpectationsWithTimeout(5, handler: nil)
        
        // Then
        if let response = response {
            XCTAssertNotNil(response.request, "request should not be nil")
            XCTAssertNotNil(response.response, "response should not be nil")
            XCTAssertEqual(response.response?.URL?.absoluteString, stubbedURL, "response url should be equal stubbedURL")
            XCTAssertEqual(response.response?.statusCode, statusCode, "request should be failed")
            XCTAssertTrue(response.result!.isFailure, "result should be failed")
            
            guard let _ = response.result!.error else {
                XCTFail("result error should not be nil")
                return
            }
        } else {
            XCTFail("response should not be nil")
        }
    }
}
