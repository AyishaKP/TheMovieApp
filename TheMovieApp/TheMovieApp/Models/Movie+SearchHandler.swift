//
//  Movie+SearchHandler.swift
//  TheMovieApp
//
//  Created by Ayisha on 15/05/18.
//  Copyright © 2018 Careem. All rights reserved.
//

import ObjectMapper
import RealmSwift

// This mappable model is used to map the response
// that comes after passing a search term and page number
// to get the list of movies that contains the search term.
//
// IMPORTANT: This model is created to map response
// that comes in application/json format from the server.
class SearchHandler: Mappable {

    var message: String?
    var success: Bool = false
    var code: String?
    var page: String?
    var totalResults: String?
    var totalPages: String?
    var movies: [Movie]?

    /// This function can be used to validate JSON prior to mapping.
    // Return nil to cancel mapping when status code is 7.
    required init?(map: Map) {

        if let code = map.JSON["status_code"] as? String, code == "7" {
            return nil
        }
    }

    // This function is where all variable mappings should occur
    // for a json received for a search api response.
    // It is executed by Mapper during the mapping (serialization and deserialization) process.
    func mapping(map: Map) {
        page <- map["page"]
        totalResults <- map["total_results"]
        totalPages <- map["total_pages"]
        movies <- map["results"]
    }
}
