//
//  Movie+Handler.swift
//  TheMovieApp
//
//  Created by Ayisha on 15/05/18.
//  Copyright © 2018 Careem. All rights reserved.
//

import ObjectMapper
import RealmSwift

class MovieHandler : Mappable {
    var status_message: String = ""
    var success: Bool = false
    var status_code: String = ""
    var page: String = ""
    var total_results: String = ""
    var total_pages: String = ""
    var movieDetails: [Movie] = []
    
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        if map.JSON["status_message"] != nil {
            self.status_message <- map["status_message"]
        }
        if map.JSON["success"] != nil {
            self.success <- map["success"]
        }
        if map.JSON["status_message"] != nil {
            self.status_message <- map["status_message"]
        }
        if map.JSON["status_code"] != nil {
            self.status_message <- map["status_code"]
        }
        if map.JSON["page"] != nil {
            self.page <- map["page"]
        }
        if map.JSON["total_results"] != nil {
            self.total_results <- map["total_results"]
        }
        if map.JSON["total_pages"] != nil {
            self.total_pages <- map["total_pages"]
        }
        if map.JSON["results"] != nil {
            self.movieDetails <- map["results.movieDetails"]
        }
    }
}
