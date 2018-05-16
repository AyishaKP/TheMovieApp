//
//  Search.swift
//  TheMovieApp
//
//  Created by Ayisha on 14/05/18.
//  Copyright © 2018 Careem. All rights reserved.
//

import Foundation
import RealmSwift

class Search: Object {
    @objc dynamic var query: String?
    @objc dynamic var timestamp: Date?

    override static func primaryKey() -> String? {
        return "query"
    }
}
