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
    
//    var session: NSURLSession?

    override func setUp() {
        super.setUp()
//        let mock = MockSession()
//        NetworkManager.session = mock
//        session = mock as MockSession
    }
    
    override func tearDown() {
        super.tearDown()
//        session = nil
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
        
        // When
        NetworkManager.request(.POST, path: .signInPath, body: ["user": "name"]) { response in
            expectation.fulfill()
        }
        
        // Then
        waitForExpectationsWithTimeout(5, handler: nil)
        
    }
}
