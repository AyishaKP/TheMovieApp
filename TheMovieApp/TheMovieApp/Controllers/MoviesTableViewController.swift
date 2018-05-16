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
    var searches: [Search]? {
        guard let realm = realm else { return nil }
        let fetchedHistory = Array(realm.objects(Search.self).sorted(byKeyPath: "timestamp"))
        var searchHistory: [Search] = []
        for index in 0...9 where index <= fetchedHistory.count - 1 {
            searchHistory.append(fetchedHistory[index])
        }
        return searchHistory
    }
    var movies: [Movie] = []
    private var page: Int = 0

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        customizeSearchBar()

        guard let realm = realm else { return }
        movies = Array(realm.objects(Movie.self))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - UI Customizations
    private func setupTableView() {
        tableView.backgroundView = UIImageView(image: UIImage(named: "backgroundImage"))
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "searchResultCell")
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
    }

    private func customizeSearchBar() {
        searchController = {
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            controller.searchBar.delegate = self
            tableView.tableHeaderView = controller.searchBar
            return controller
        }()
    }

    // MARK: - Search API Handling

    func fetchMovies(with searchText: String) {
        searchController.dismiss(animated: true, completion: nil)
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
    }
}
