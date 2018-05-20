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

class MoviesTableViewController: UITableViewController {

    /// Variables
    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM, yyyy"
        return dateFormatter
    }()
    var searchController = UISearchController()
    var searches: [Search]?
    var movies: [Movie] = []
    var currentSearch: Search?
    var page: Int = 0
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

    // MARK: - UI Customizations
    private func customizeTableView() {
        title = "M O V I E"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "searchResultCell")
        tableView.keyboardDismissMode = .interactive
    }

    // MARK: - Search Customizations
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
