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

extension MoviesTableViewController: UISearchBarDelegate, UISearchResultsUpdating {

    // MARK: - UISearchBarDelegate

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchController.isActive = true
        tableView.reloadData()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        guard let searchString = searchController.searchBar.text, searchString.count > 0 else {
            movies.removeAll()
            tableView.reloadData()
            return
        }
        fetchMovies(with: searchString)
    }

    // MARK: - UISearchResultsUpdating

    func updateSearchResults(for searchController: UISearchController) {

    }
}
