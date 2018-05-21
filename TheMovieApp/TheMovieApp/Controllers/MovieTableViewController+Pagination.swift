//
//  MovieTableViewController+Pagination.swift
//  TheMovieApp
//
//  Created by Ayisha on 18/05/18.
//  Copyright © 2018 Careem. All rights reserved.
//

import UIKit

/// This extension will handle the scroll view delegate for handing pagination.
extension MoviesTableViewController {

    /// Implemented for pagination
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if !searchController.isActive {
            let scrollViewContenteHeight = scrollView.contentSize.height
            let currentOffset = scrollView.contentOffset.y
            let endOfPage = Int(currentOffset + scrollView.frame.size.height) >=  Int(scrollViewContenteHeight)
            guard movies.count > 0, endOfPage, !isLoading else { return }
            isLoading = true
            tableView.reloadData()
            let indexPath = IndexPath(row: 0, section: movies.count)
            tableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
            guard let currentQuery = self.currentSearch?.query else { return }
            self.fetchMovies(with: currentQuery)
        }
    }
}
