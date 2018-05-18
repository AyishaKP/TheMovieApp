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

    // MARK: - Variables
    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM, yyyy"
        return dateFormatter
    }()
    var searchController = UISearchController()
    var realm: Realm? {
        do {
            return try Realm()
        } catch {
            return nil
        }
    }
     var searchHistory: [Search]? {
        guard let realm = realm else { return nil }
        let fetchedHistory = Array(realm.objects(Search.self).sorted(byKeyPath: "timestamp"))
        var searchHistory: [Search] = []
        for (index, value) in fetchedHistory.enumerated() where index < 10 {
            searchHistory.append(value)
        }
        return searchHistory
    }
    var searches: [Search]?
    var movies: [Movie] = []
    var page: Int = 0
    var isLoading: Bool = false
    var currentSearch: Search?

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        customizeTableView()
        customizeSearchBar()

        /* Load stored movies by uncommenting the below lines */
        // guard let realm = realm else { return }
        // movies = Array(realm.objects(Movie.self))

        searches = searchHistory
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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "loadMoreCell")
        tableView.keyboardDismissMode = .interactive
    }

    private func customizeSearchBar() {
        searchController = {
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
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
