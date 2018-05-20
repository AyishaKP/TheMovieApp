//
//  MovieTableViewControlller+EmptyDataSet.swift
//  TheMovieApp
//
//  Created by Ayisha on 16/05/18.
//  Copyright © 2018 Careem. All rights reserved.
//

import UIKit
import EmptyDataSet_Swift

/// This extension will handle the table view empty data set placeholder delegates and datasource.
extension MoviesTableViewController: EmptyDataSetSource, EmptyDataSetDelegate {

    // MARK: - EmptyDataSetSource
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        return NSAttributedString(string: "Its empty around here!")
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        return NSAttributedString(string: "Please search for a movie")
    }
    
    func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
        return UIImage(named: "ic_movie")
    }
    
    func buttonTitle(forEmptyDataSet scrollView: UIScrollView, for state: UIControlState) -> NSAttributedString? {
        return NSAttributedString(string: "T A P  M E",
                                  attributes: [NSAttributedStringKey.backgroundColor: UIColor.darkRed,
                                               NSAttributedStringKey.foregroundColor: UIColor.swanWhite])
    }
    
    // MARK: - EmptyDataSetDelegate Methods
    
    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView) -> Bool {
        return true
    }

    func emptyDataSetShouldAllowTouch(_ scrollView: UIScrollView) -> Bool {
        return true
    }

    func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView) -> Bool {
        return true
    }

    func emptyDataSet(_ scrollView: UIScrollView, didTapButton button: UIButton) {
        searchController.searchBar.becomeFirstResponder()
        searchController.isActive = true
        tableView.reloadData()
    }
}
