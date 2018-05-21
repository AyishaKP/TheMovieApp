//
//  LatoFontExtensionTests.swift
//  TheMovieAppTests
//
//  Created by Ayisha on 20/05/18.
//  Copyright © 2018 Careem. All rights reserved.
//

import XCTest

class LatoFontExtensionTests: XCTestCase {
    
    private struct Constants {
        static let lightLato = "Lato-Light"
        static let regularLato = "Lato-Regular"
        static let mediumLato = "Lato-Medium"
        static let boldLato = "Lato-Bold"
        static let blackLato = "Lato-Black"
    }
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testFontDescription() {
        XCTAssertEqual(UIFont.LatoFont.light.description, Constants.lightLato)
        XCTAssertEqual(UIFont.LatoFont.regular.description, Constants.regularLato)
        XCTAssertEqual(UIFont.LatoFont.medium.description, Constants.mediumLato)
        XCTAssertEqual(UIFont.LatoFont.bold.description, Constants.boldLato)
        XCTAssertEqual(UIFont.LatoFont.black.description, Constants.blackLato)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
