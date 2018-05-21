//
//  MoviesTableViewController.swift
//  TheMovieApp
//
//  Created by Ayisha on 14/05/18.
//  Copyright © 2018 Careem. All rights reserved.
//

import UIKit
import SDWebImage
import RealmSwift
import EmptyDataSet_Swift

/**
 This table view controller will show the list of movies
 as well as a search list
 */
class MoviesTableViewController: UITableViewController {

    /// Date formatter for displaying release date
    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM, yyyy"
        return dateFormatter
    }()

    /// Search controller used to search for movies
    var searchController = UISearchController()

    /// Array having recent searches and can have a maximum of 10 recent searches.
    var searches: [Search]?

    /// Array having list of movies fetched from server.
    var movies: [Movie] = []

    /**
      Variable that references to the current search
      for which the movies list is being displayed.
     */
    var currentSearch: Search?

    /// Variable that stores the current number of pages that are already loaded.
    var page: Int = 0

    /// Bool value indicating weather there is an ongoing request for fetching the movies.
    var isLoading: Bool = false

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        customizeTableView()
        customizeSearchBar()

        /* Load stored movies by uncommenting the below lines
        // guard let realm = realm else { return }
        // movies = Array(realm.objects(Movie.self))
         */

        searches = RealmManager.shared.searchHistory
        if movies.count == 0 {
            tableView.emptyDataSetSource = self
            tableView.emptyDataSetDelegate = self
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /// A method that takes care of UI Customizations
    private func customizeTableView() {
        title = "M O V I E"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "searchResultCell")
        tableView.keyboardDismissMode = .interactive
    }

    /**
     A method that takes care of creating a search controller
     and adding it to the tableView header.
    */
    private func customizeSearchBar() {
        searchController = {
            let controller = UISearchController(searchResultsController: nil)
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            controller.searchBar.searchBarStyle = .minimal
            controller.searchBar.tintColor = UIColor.white
            controller.searchBar.placeholder = "Search for a movie"
            controller.searchBar.delegate = self
            controller.searchBar.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            tableView.tableHeaderView = controller.searchBar
            return controller
        }()
    }

}
