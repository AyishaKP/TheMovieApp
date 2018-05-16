//
//  Movie.swift
//  TheMovieApp
//
//  Created by Ayisha on 14/05/18.
//  Copyright © 2018 Careem. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

class Movie: Object, Mappable {
    @objc dynamic var movieId: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var originalTitle: String = ""
    @objc dynamic var posterPath: String = ""
    @objc dynamic var overview: String = ""
    @objc dynamic var voteCount = ""
    @objc dynamic var popularity: String = ""
    @objc dynamic var originalLanguage: String = ""
    @objc dynamic var releaseDate: Date?
    @objc dynamic var backdropPath: String = ""

    required convenience init?(map: Map) {
        self.init()
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

    override static func primaryKey() -> String? {
        return "movieId"
    }
}
