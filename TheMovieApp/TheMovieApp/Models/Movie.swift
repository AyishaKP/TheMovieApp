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

/**
- This mappable model is used to map the json
- with in a search result to parse the list of movies.
- This model is used to save in Realm database,
- incase you need to cache the movies info.
//
- **IMPORTANT**: This model is created to map response
- that comes in application/json format from the server.
 */
class Movie: Object, Mappable {

    /// Parameters for search.
    @objc dynamic var movieId: Int = 0
    @objc dynamic var title: String?
    @objc dynamic var originalTitle: String?
    @objc dynamic var posterPath: String?
    @objc dynamic var overview: String?
    @objc dynamic var voteCount: String?
    @objc dynamic var popularity: String?
    @objc dynamic var originalLanguage: String?
    @objc dynamic var releaseDate: Date?
    @objc dynamic var backdropPath: String?

    /// Parameters for search.
    required convenience init?(map: Map) {
        self.init()
    }

    /**
    - This function is where all variable mappings should occur
      for a json with info regarding a movie record.
    - It is executed by Mapper during the mapping (serialization and deserialization) process.
    */
    func mapping(map: Map) {
        movieId <- map["id"]
        title <- map["title"]
        originalTitle <- map["original_title"]
        posterPath <- map["poster_path"]
        overview <- map["overview"]
        voteCount <- map["vote_count"]
        popularity <- map["popularity"]
        originalLanguage <- map["original_language"]
        releaseDate <- (map["release_date"], DateTransform(dateFormat: "yyyy-MM-dd"))
        backdropPath <- map["backdrop_path"]
    }

    /// Used primary key to make the searches unique.
    override static func primaryKey() -> String? {
        return "movieId"
    }
}
