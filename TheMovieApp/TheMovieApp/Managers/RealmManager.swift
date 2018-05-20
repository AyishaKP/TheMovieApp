//
//  RealmManager.swift
//  TheMovieApp
//
//  Created by Ayisha on 19/05/18.
//  Copyright © 2018 Careem. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyBeaver

/// Created a Realm Manager to manage to save and fetche objects from the database.
final class RealmManager {

    /// Singleton Instance
    static let shared: RealmManager = RealmManager()

    /// Access to initializer restricted.
    private init() {

    }

    /// This variable is used to instantiate a realm instance to fetch, save or delete realm objects.
    private var realm: Realm? {
        do {
            return try Realm()
        } catch {
            return nil
        }
    }

    /// This variable is used to fetch a search history consisting of last 10 successful query.
    var searchHistory: [Search]? {
        guard let realm = realm else { return nil }
        let fetchedHistory = Array(realm.objects(Search.self).sorted(byKeyPath: "timestamp", ascending: false))
        var searchHistory: [Search] = []
        for (index, value) in fetchedHistory.enumerated() where index < 10 {
            searchHistory.append(value)
        }
        return searchHistory
    }

    /// This method is used to save a new search text or update an existing one.
    func save(_ newSearch: String, saveHandler:  @escaping (Search) -> Void ) {
        do {
            let realm = try Realm()
            let search = Search()
            try realm .write {
                search.query = newSearch
                search.timestamp = Date()
                realm.add(search, update: true)
            }
            saveHandler(search)
        } catch let error as NSError {
            SwiftyBeaver.debug(error.localizedDescription)
        }
    }

    /// This method is used to handle new movies and save or update to the Realm database.
    func save(_ newMovies: [Movie]) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(newMovies, update: true)
            }

        } catch let error as NSError {
            SwiftyBeaver.debug(error.localizedDescription)
        }
    }
}
