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
        NetworkManager.sharedManager.session = MockSession()
    }
    
    override func tearDown() {
        
        super.tearDown()
    }
}
