//
//  MoviesTableViewController.swift
//  TheMovieApp
//
//  Created by Ayisha on 14/05/18.
//  Copyright © 2018 Careem. All rights reserved.
//

import UIKit
import PromiseKit
import SwiftyBeaver
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
        } catch let error as NSError {
            SwiftyBeaver.debug(error.localizedDescription)
            return nil
        }
    }
    private var searchHistory: [Search]? {
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
    private var page: Int = 0

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        customizeSearchBar()

        guard let realm = realm else { return }
        movies = Array(realm.objects(Movie.self))
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
    private func setupTableView() {
        title = "M O V I E"
        tableView.backgroundView = UIImageView(image: UIImage(named: "backgroundImage"))
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "searchResultCell")
        tableView.keyboardDismissMode = .interactive
    }

    private func customizeSearchBar() {
        searchController = {
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            controller.searchBar.searchBarStyle = .minimal
            controller.searchBar.backgroundColor = UIColor.transparentBlack
            controller.searchBar.tintColor = UIColor.white
            controller.searchBar.placeholder = "Search your movie"
            controller.searchBar.delegate = self
            tableView.tableHeaderView = controller.searchBar
            return controller
        }()
    }

    // MARK: - Search API Handling

    func fetchMovies(with searchText: String) {
        searchController.dismiss(animated: true, completion: nil)
        if NetworkManager.shared.isReachable {
            firstly { () -> Promise<SearchHandler> in
                Movie.Router.search(searchText, page: page + 1).createRequest()
                }.then { [weak self] (handler: SearchHandler) -> Void in

                    guard let weakSelf = self else { return }

                    guard handler.movies.count > 0 else {
                        weakSelf.movies.removeAll()
                        DispatchQueue.main.async {
                            weakSelf.tableView.reloadData()
                        }
                        return
                    }
                    do {
                        let realm = try Realm()
                        let search = Search()
                        try realm .write {
                            search.query = searchText
                            search.timestamp = Date()
                            realm.add(search, update: true)
                        }
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
                    weakSelf.movies = handler.movies
                    DispatchQueue.main.async {
                        weakSelf.tableView.reloadData()
                    }
                }.catch { err in
                    if let error: ServiceError = err as? ServiceError {
                        SwiftyBeaver.error(error.localizedDescription)
                    }
            }
        } else {

        }

    }
}
