//
//  MoviesTableViewController+WebService.swift
//  TheMovieApp
//
//  Created by Ayisha on 18/05/18.
//  Copyright © 2018 Careem. All rights reserved.
//

import Foundation
import PromiseKit
import SwiftyBeaver
import RealmSwift

extension MoviesTableViewController {

    // MARK: - Search API Handling

    func fetchMovies(with searchText: String) {
        searchController.dismiss(animated: true, completion: nil)
        if NetworkManager.shared.isReachable {
            isLoading = true
            if let currentQuery = currentSearch?.query, currentQuery != searchText {
                page = 0
            }
            if page == 0 {
                movies.removeAll()
            }
            firstly { () -> Promise<SearchHandler> in
                Movie.Router.search(searchText, page: page + 1).createRequest()
                }.then { [weak self] (handler: SearchHandler) -> Void in

                    guard let weakSelf = self else { return }
                    weakSelf.isLoading = false
                    guard handler.movies.count > 0 else {
                        weakSelf.tableView.reloadData()
                        return
                    }
                    weakSelf.page += 1
                    do {
                        let realm = try Realm()
                        let search = Search()
                        try realm .write {
                            search.query = searchText
                            search.timestamp = Date()
                            realm.add(search, update: true)
                        }
                        weakSelf.currentSearch = search
                        weakSelf.searches = weakSelf.searchHistory
                    } catch let error as NSError {
                        SwiftyBeaver.debug(error.localizedDescription)
                    }

                    do {
                        let realm = try Realm()
                        try realm.write {
                            realm.add(handler.movies, update: true)
                        }
                    } catch let error as NSError {
                        SwiftyBeaver.debug(error.localizedDescription)
                    }
                    handler.movies.forEach { weakSelf.movies.append($0) }
                    DispatchQueue.main.async {
                        weakSelf.tableView.reloadData()
                    }
                }.catch { [weak self] err in
                    if let error: ServiceError = err as? ServiceError {
                        guard let weakSelf = self else { return }
                        weakSelf.showAlert(message: "\(error.localizedDescription)",
                                  title: "Error") { (_) in
                                    weakSelf.searchController.searchBar.becomeFirstResponder()
                        }
                    }
                }
        } else {
            showAlert(message: "Whoops!! It seems like the server is not reachable. Please try again.",
                      title: "Network Error") { [unowned self] (_) in
                self.searchController.searchBar.becomeFirstResponder()
            }
        }
    }
}
