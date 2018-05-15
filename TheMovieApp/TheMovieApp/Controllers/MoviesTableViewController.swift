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

class MoviesTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        firstly { () -> Promise<SearchHandler> in
            Movie.Router.search("batman", page: 1).createRequest()
            }.then { (handler: SearchHandler) -> Void in
                SwiftyBeaver.debug(handler.message)
                SwiftyBeaver.debug(handler.totalResults)
            }.catch { err in
                if let error: ServiceError = err as? ServiceError {
                    SwiftyBeaver.error(error.localizedDescription)
                }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieListCellID",
                                                 for: indexPath) as? MovieTableViewCell
        cell?.textLabel?.text = "hi"
        return cell!
    }

}
