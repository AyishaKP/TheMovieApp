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
    var movieId: String = ""
    var title: String = ""
    var originalTitle: String = ""
    var posterPath: String = ""
    var overview: String = ""
    var voteCount = ""
    var popularity: String = ""
    var originalLanguage: String = ""
    var releaseDate = Date()
    var backdropPath: String = ""

    required init?(map: Map) {
    }
    func mapping(map: Map) {
        movieId <- map["id"]
        title <- map["title"]
        originalTitle <- map["original_title"]
        posterPath <- map["poster_path"]
        overview <- map["overview"]
        voteCount <- map["vote_count"]
        popularity <- map["popularity"]
        originalLanguage <- map["original_language"]
        releaseDate <- (map["release_date"], DateTransform())
        backdropPath <- map["backdrop_path"]
    }
}
