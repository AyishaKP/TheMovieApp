//
//  Movie+SearchHandler.swift
//  TheMovieApp
//
//  Created by Ayisha on 15/05/18.
//  Copyright © 2018 Careem. All rights reserved.
//

import ObjectMapper
import RealmSwift

class SearchHandler: Mappable {
    var message: String = ""
    var success: Bool = false
    var code: String = ""
    var page: String = ""
    var totalResults: String = ""
    var totalPages: String = ""
    var movies: [Movie] = []

    required init?(map: Map) {

        if let code = map.JSON["status_code"] as? String, code == "7" {
            return nil
        }
    }

    func mapping(map: Map) {
        page <- map["page"]
        totalResults <- map["total_results"]
        totalPages <- map["total_pages"]
        movies <- map["results"]
    }
}
