//
//  DateTransformTests.swift
//  TheMovieAppTests
//
//  Created by Ayisha on 19/05/18.
//  Copyright © 2018 Careem. All rights reserved.
//

import XCTest
import ObjectMapper
@testable import TheMovieApp

class DateTransformTests: XCTestCase {
    
    let mapper = Mapper<DateType>()

    private struct Constants {
        static let inputDateString = "23-04-1993"
    }
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDataTransform() {
        
        let mappedObject = mapper.map(JSONObject: ["date": Constants.inputDateString])
        
        let convertDateFormatter = DateFormatter()
        convertDateFormatter.dateFormat = "dd-MM-yyyy"
        
        XCTAssertNotNil(mappedObject)
        XCTAssertEqual(mappedObject?.stringDate, Constants.inputDateString)
        XCTAssertEqual(convertDateFormatter.string(from: (mappedObject?.date)!), Constants.inputDateString)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            _ = Mapper<DateType>().map(JSONObject: ["date": Constants.inputDateString])
        }
    }
}

class DateType: Mappable {
    
    var date: Date?
    var stringDate: String?
    
    init(){
        
    }
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        stringDate <- map["date"]
        date <- (map["date"], DateTransform(dateFormat: "dd-MM-yyyy"))
    }
}
