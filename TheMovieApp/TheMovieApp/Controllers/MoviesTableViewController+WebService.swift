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
            setup(new: searchText)
            sendRequest(with: searchText)
        } else {
            let serviceError = ServiceError.connectionError
            show(with: serviceError) { (_) in self.searchController.searchBar.becomeFirstResponder() }
        }
    }

    // setting up a new search to reset movies and page number.
    func setup(new searchText: String) {
        isLoading = true
        if let currentQuery = currentSearch?.query, currentQuery != searchText {
            page = 0
        }
        if page == 0 {
            movies.removeAll()
        }
    }

    // Send request using PromiseKit based blocks
    // which gives the 'then' success completion block,
    // and failure block is received using catch block.
    //
    // 'firstly' block is used to create a promise instance
    // initiated with the response model.
    //
    // 'then' block is used to handle the response,
    // based on the model provided in the 'firstly' block.
    //
    // Used the RealmManager to save the current search to support auto population and movies in the response.
    //
    // catch block will receive all errors that were caught.
    func sendRequest(with searchText: String) {
        firstly { () -> Promise<SearchHandler> in
            Movie.Router.search(searchText, page: page + 1).createRequest()
            }.then { [weak self] (handler: SearchHandler) -> Void in

                guard let weakSelf = self else { return }
                weakSelf.isLoading = false
                guard let newMovies = handler.movies, newMovies.count > 0 else {
                    weakSelf.tableView.reloadData()
                    return
                }
                weakSelf.page += 1
                RealmManager.shared.save(searchText) { (search) in
                    weakSelf.currentSearch = search
                    weakSelf.searches = RealmManager.shared.searchHistory
                }

                RealmManager.shared.save(newMovies)
                newMovies.forEach { weakSelf.movies.append($0) }
                DispatchQueue.main.async {
                    weakSelf.tableView.reloadData()
                }

            }.catch { [weak self] err in
                if let error: ServiceError = err as? ServiceError {
                    guard let weakSelf = self else { return }
                    weakSelf.show(with: error) { (_) in weakSelf.searchController.searchBar.becomeFirstResponder() }
            }
        }
    }
}
