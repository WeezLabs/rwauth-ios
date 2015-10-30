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
    
    func testSuccessPost() {
        // Given
        let stubbedURL = "http://exampledomain.com" + AuthPath.signInPath.rawValue
        let requestBody: [String: AnyObject] = ["user": "name"]
        let answerBody: [String: AnyObject] = ["status": "OK"]
        
        let mock = MockSession()
        NetworkManager.session = mock
        mock.stub()
        mock.stubRequest("POST", url: stubbedURL, requestBody: requestBody, returnCode: 200, answerBody: answerBody)
        
        let expectation = expectationWithDescription("request should be successful")
        var response: Response<Any, NSError>? = nil
        
        // When
        NetworkManager.request(.POST, path: .signInPath, body: ["user": "name"]) { closureResponse in
            response = closureResponse as! Response<Any, NSError>
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(5, handler: nil)
        
        // Then
        if let response = response {
            XCTAssertNotNil(response.request, "request should not be nil")
            XCTAssertNotNil(response.response, "response should not be nil")
            XCTAssertNotNil(response.data, "data should not be nil")
            XCTAssertTrue(response.result!.isSuccess, "result should be success")
            
            guard let value = response.result!.value else {
                XCTFail("result value should not be nil")
                return
            }
            XCTAssertEqual(value as! NSDictionary, answerBody as NSDictionary, "Should be equal")
        } else {
            XCTFail("response should not be nil")
        }
    }
}
