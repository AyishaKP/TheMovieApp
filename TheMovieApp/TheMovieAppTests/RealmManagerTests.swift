//
//  RealmManagerTests.swift
//  TheMovieAppTests
//
//  Created by Ayisha on 20/05/18.
//  Copyright © 2018 Careem. All rights reserved.
//

import XCTest
import RealmSwift
@testable import TheMovieApp

class RealmManagerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        RealmManager.shared.realm?.deleteAll()
    }
    
    func testRealmVariable() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let realm = RealmManager.shared.realm
        XCTAssertNotNil(realm, "Realm variable should not be nil")
    }

    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
