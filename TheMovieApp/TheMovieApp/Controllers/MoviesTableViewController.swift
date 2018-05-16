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

class MoviesTableViewController: UITableViewController {

    private var movies: [Movie] = []
    private var page: Int = 0
    private let dateFormatter: DateFormatter = DateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundView = UIImageView(image: UIImage(named: "backgroundImage"))
        firstly { () -> Promise<SearchHandler> in
            Movie.Router.search("batman", page: page + 1).createRequest()
        }.then { [weak self] (handler: SearchHandler) -> Void in
            guard let weakSelf = self else { return }
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieListCellId",
                                                 for: indexPath) as? MovieTableViewCell
        let movieResult = movies[indexPath.row]
        let imageUrlPath = Movie.Router.imageUrl
        let imageUrl = URL(string: imageUrlPath)?.appendingPathComponent(movieResult.posterPath)
        cell?.posterImageView.sd_setImage(with: imageUrl, placeholderImage:
            UIImage(named: "ic_poster_placeholder"), options: .highPriority, completed: nil)
        cell?.titleNameLabel.text = movieResult.title
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: movieResult.releaseDate)
        cell?.releaseDateLabel.text = "Release date: \(dateString)"
        cell?.overViewLabel.text = "OverView: \(movieResult.overview)"
        cell?.contentView.layer.borderColor = UIColor.swanWhite.cgColor
        cell?.contentView.layer.borderWidth = 1
        return cell!
    }

}
