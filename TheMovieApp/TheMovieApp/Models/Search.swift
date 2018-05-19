//
//  Search.swift
//  TheMovieApp
//
//  Created by Ayisha on 14/05/18.
//  Copyright © 2018 Careem. All rights reserved.
//

import Foundation
import RealmSwift

// Created Search model for saving the search text and to manage the time stamp
// Timestamp is used to show last 10 successful queries.
class Search: Object {
    
    @objc dynamic var query: String?
    @objc dynamic var timestamp: Date?

    // Used primary key to make the searches unique.
    override static func primaryKey() -> String? {
        return "query"
    }
}
