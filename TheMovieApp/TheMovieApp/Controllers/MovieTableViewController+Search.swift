//
//  MovieTableViewController+Search.swift
//  TheMovieApp
//
//  Created by Ayisha on 16/05/18.
//  Copyright © 2018 Careem. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftyBeaver

extension MoviesTableViewController: UISearchBarDelegate {

    // MARK: - UISearchBarDelegate
    /**
    - This method call when search bar becomes first responder.
    - Makes sure that the tableView is reloaded to show auto suggestions.
     */
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchController.isActive = true
        tableView.reloadData()
    }

    /// This method validate the search text and fetch the movies from server.
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        guard let searchString = searchController.searchBar.text, searchString.count > 0 else {
            searchController.isActive = false
            movies.removeAll()
            tableView.reloadData()
            return
        }
        fetchMovies(with: searchString)
    }
    /**
    - This method call when cancel button in search bar is pressed.
    - Makes sure that the tableView is reloaded to show the movies for last searched text.
     */
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchController.isActive = false
        searchController.searchBar.text = currentSearch?.query
        tableView.reloadData()
    }

}
