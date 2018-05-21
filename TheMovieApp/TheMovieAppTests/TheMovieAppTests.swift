//
//  TheMovieAppTests.swift
//  TheMovieAppTests
//
//  Created by Ayisha on 14/05/18.
//  Copyright © 2018 Careem. All rights reserved.
//

import XCTest
import PromiseKit
@testable import TheMovieApp

class TheMovieAppTests: XCTestCase {
    var sessionUnderTest: URLSession!

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sessionUnderTest = URLSession(configuration: URLSessionConfiguration.default)

    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sessionUnderTest = nil
        super.tearDown()

    }
    
    func testValidCallToMoviesGetsHTTPStatusCode200() {
        // given
        let url = URL(string: "http://api.themoviedb.org/3/search/movie?api_key=2696829a81b1b5827d515ff121700838&query=batman&page=1")
        // 1
        let promise = expectation(description: "Status code: 200")
        
        // when
        let dataTask = sessionUnderTest.dataTask(with: url!) { data, response, error in
            // then
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    // 2
                    promise.fulfill()
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        dataTask.resume()
        // 3
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
