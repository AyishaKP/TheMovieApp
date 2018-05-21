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
    
    private struct Constants {
        static let inputSearchTerm = "batman"
        static let inputMovieTitle = "Batman"
    }
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        do {
            try? RealmManager.shared.realm?.write {
                RealmManager.shared.realm?.deleteAll()
            }
        }
    }
    
    func testInit() {
        XCTAssertNotNil(RealmManager.shared, "Realm manager should be a singleton class")
    }
    
    func testRealmVar() {
        XCTAssertNotNil(RealmManager.shared.realm, "Realm should be accessible")
    }
    
    func testSaveSearch() {
        RealmManager.shared.save(Constants.inputSearchTerm) { (search) in
            XCTAssertTrue(search.query! == Constants.inputSearchTerm, "The input search term should be same as the search model query created using it.")
        }
    }
    
    func testSaveMovies() {
        let movies:[Movie] = [Movie(JSON: ["id":1, "title": Constants.inputMovieTitle])!]
        RealmManager.shared.save(movies)
        let fetchedMovies = RealmManager.shared.realm?.objects(Movie.self)
        XCTAssertTrue(fetchedMovies?.count == movies.count, "There should be same number of movies as saved")
        XCTAssertTrue(fetchedMovies?.first?.title! == Constants.inputMovieTitle, "The input movie title should be same as the movie model title created using it.")
    }
}
