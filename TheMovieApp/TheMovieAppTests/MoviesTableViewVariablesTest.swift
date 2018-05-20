//
//  MoviesTableViewVariablesTest.swift
//  TheMovieAppTests
//
//  Created by Ayisha on 20/05/18.
//  Copyright © 2018 Careem. All rights reserved.
//

import XCTest
import UIKit
import RealmSwift
@testable import TheMovieApp

class MoviesTableViewVariablesTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSearchArrayNotEmpty() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let storyboard = UIStoryboard(name: "Movies", bundle: nil)
        let movieTVC = storyboard.instantiateViewController(withIdentifier: "MoviesTableViewControllerID") as! MoviesTableViewController
        let searchSave = {
         RealmManager.shared.save("batman")
        { (search) in
            movieTVC.currentSearch = search
            movieTVC.searches = RealmManager.shared.searchHistory
        }
        }
        XCTAssertNotNil(searchSave, "Search results should not be empty when there is a search results")
    }
    

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
