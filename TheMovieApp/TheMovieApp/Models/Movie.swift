//
//  Movie.swift
//  TheMovieApp
//
//  Created by Ayisha on 14/05/18.
//  Copyright © 2018 Careem. All rights reserved.
//

import Foundation
import ObjectMapper

class Movie: Mappable {
    var movieID: String = ""
    var title: String = ""
    var original_title: String = ""
    var poster_path: String = ""
    var overview: String = ""
    var vote_count = ""
    var popularity: String = ""
    var original_language: String = ""
    var release_date: String = ""
    var backdrop_path: String = ""

    required convenience init?(map: Map) {
        self.init()
    }
    func mapping(map: Map) {
        if map.JSON["id"] != nil {
            self.movieID <- map["id"]
        }
        if map.JSON["title"] != nil {
            self.title <- map["title"]
        }
        if map.JSON["original_title"] != nil {
            self.original_title <- map["original_title"]
        }
        if map.JSON["poster_path"] != nil {
            self.poster_path <- map["poster_path"]
        }
        if map.JSON["overview"] != nil {
            self.overview <- map["overview"]
        }
        if map.JSON["vote_count"] != nil {
            self.vote_count <- map["vote_count"]
        }
        if map.JSON["popularity"] != nil {
            self.popularity <- map["popularity"]
        }
        if map.JSON["original_language"] != nil {
            self.original_language <- map["original_language"]
        }
        if map.JSON["release_date"] != nil {
            self.release_date <- map["release_date"]
        }
        if map.JSON["backdrop_path"] != nil {
            self.backdrop_path <- map["backdrop_path"]
        }
    }
}
