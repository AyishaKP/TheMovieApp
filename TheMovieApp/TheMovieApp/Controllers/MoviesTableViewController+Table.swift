//
//  MoviesTableViewController+Table.swift
//  TheMovieApp
//
//  Created by Ayisha on 16/05/18.
//  Copyright © 2018 Careem. All rights reserved.
//

import UIKit

extension MoviesTableViewController {

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        if searchController.isActive {
            return 1
        }
        if isLoading {
            return movies.count + 1
        }
        return movies.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive {
            return searches?.count ?? 0
        }
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if !searchController.isActive && isLoading && indexPath.section == movies.count {
            let loadCell = tableView.dequeueReusableCell(withIdentifier:
                "loadMoreCell", for: indexPath)
            loadCell.textLabel?.text = "Loading..."
            loadCell.textLabel?.textAlignment = .center
            loadCell.backgroundColor = UIColor.transparentBlack
            loadCell.textLabel?.font = UIFont.latoFont(.medium, size: 14)
            loadCell.textLabel?.textColor = UIColor.swanWhite
            return loadCell
        } else if searchController.isActive {

            let cell = tableView.dequeueReusableCell(withIdentifier:
                "searchResultCell", for: indexPath)
            cell.backgroundColor = UIColor.transparentBlack
            cell.textLabel?.font = UIFont.latoFont(.medium, size: 14)
            cell.textLabel?.textColor = UIColor.swanWhite
            if let search = searches?[indexPath.row] {
                cell.textLabel?.text = search.query
            }
            return cell
        }

        guard let movieCell = tableView.dequeueReusableCell(withIdentifier: "movieListCellId",
                                                            for: indexPath) as? MovieTableViewCell
            else { fatalError("Must have a cell of type MovieTableViewCell") }
        let movie = movies[indexPath.section]
        let imageUrlPath = Movie.Router.imageUrl
        if let posterPath = movie.posterPath {
            let imageUrl = URL(string: imageUrlPath)?.appendingPathComponent(posterPath)
            movieCell.posterImageView.sd_setImage(with: imageUrl,
                                                  placeholderImage: UIImage(named: "ic_poster_placeholder"),
                                                  options: .highPriority,
                                                  completed: nil)
        }

        movieCell.titleNameLabel.text = movie.title
        if let releaseDate = movie.releaseDate {
            let releaseDateString = dateFormatter.string(from: releaseDate)
            movieCell.releaseDateLabel.text = "Release Date: \(releaseDateString)"
        }

        movieCell.overViewLabel.text = "OverView: \(movie.overview ?? "")"
        movieCell.contentView.layer.borderColor = UIColor.swanWhite.cgColor
        movieCell.contentView.layer.borderWidth = 1
        return movieCell
    }

    // MARK: - Table view delegates

    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if searchController.isActive {
            if let searchItem = searches?[indexPath.row] {
                searchController.searchBar.text = searchItem.query
                searchController.searchBar.becomeFirstResponder()
            }
        }
    }

}
