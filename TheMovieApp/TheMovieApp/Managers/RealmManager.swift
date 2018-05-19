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

class RealmManager {
    static let shared: RealmManager = RealmManager()
    var realm: Realm? {
        do {
            return try Realm()
        } catch {
            return nil
        }
    }

    // This method is used to save a new search text or update an existing one.
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

    // This method is used to handle new movies and save or update to the Realm database.
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
