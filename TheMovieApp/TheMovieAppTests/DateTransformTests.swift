//
//  DateTransformTests.swift
//  TheMovieAppTests
//
//  Created by Ayisha on 19/05/18.
//  Copyright © 2018 Careem. All rights reserved.
//

import XCTest
@testable import TheMovieApp
class DateTransformTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDateTransformCheck() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let dateS = "23-04-1993"
        let dateTransform = DateTransform(dateFormat: "dd-MM-yyyy")
        let date = dateTransform.transformFromJSON(dateS)
        let convD = dateTransform.transformToJSON(date)
        XCTAssertEqual(dateS, convD, "The input and ouput should be equal")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
