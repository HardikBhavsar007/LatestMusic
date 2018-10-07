//
//  PracticalTests.swift
//  PracticalTests
//
//  Created by Hardik Bhavsar on 06/10/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import XCTest
@testable import Practical

class PracticalTests: XCTestCase {
    
    var row10 : Int!
    var row73 : Int!
    var row340 : Int!
    
    override func setUp() {
        super.setUp()
        
        row10 = 10
        row73 = 73
        row340 = 340
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testLogicOfShowingCells() {
        
        let objVc = VcShowReleases()
        
        XCTAssert(objVc.whichCellToUse(row10) == 1, "It sholud be cell type one.")
        
        XCTAssert(objVc.whichCellToUse(row73) == 3, "It sholud be cell type three.")
        
        XCTAssert(objVc.whichCellToUse(row340) == 3, "It sholud be cell type three.")
        
    }
    
    func testSuccessfulResponse() {
        // Setup our objects
        let session = NetworkSessionMock()
        let manager = NetworkManager(session: session)
        
        // Create data and tell the session to always return it
        let data = Data(base64Encoded: "Some Data")
        session.data = data
        
        // Create a URL (using the file path API to avoid optionals)
        let url = URL(fileURLWithPath: "url")
        
        // Perform the request and verify the result
        manager.loadData(from: url) { (_, result) in
            XCTAssertEqual(result, NetworkResult.success)
        }
        
    }
    
    func testFailedResponse() {
        // Setup our objects
        let session = NetworkSessionMock()
        let manager = NetworkManager(session: session)
        
        // Create error and tell the session return failure
        session.error = MockError()
        
        // Create a URL (using the file path API to avoid optionals)
        let url = URL(fileURLWithPath: "url")
        
        // Perform the request and verify the result
        manager.loadData(from: url) { (_, result) in
            XCTAssertEqual(result, NetworkResult.failure)
        }
        
    }
    
}
