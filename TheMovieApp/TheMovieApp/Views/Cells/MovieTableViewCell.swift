//
//  MovieTableViewCell.swift
//  TheMovieApp
//
//  Created by Ayisha on 14/05/18.
//  Copyright © 2018 Careem. All rights reserved.
//

import UIKit

/// This class is used to customize a movie cell.
class MovieTableViewCell: UITableViewCell {

    /// Poster imageview used ot display the poster of the movie.
    @IBOutlet weak var posterImageView: UIImageView!

    /// Title name label displays the movie title.
    @IBOutlet weak var titleNameLabel: UILabel!

    /// Release date label displays the release date of the movie.
    @IBOutlet weak var releaseDateLabel: UILabel!

    /// Overview label displays an overview of the movie.
    @IBOutlet weak var overViewLabel: UILabel!

    /// Poster container view is the super view for titleNameLabel and releaseDateLabel,
    /// and is used to provide a gradient to make sure the labels appears as expected.
    @IBOutlet weak var posterContainerView: UIView!

    /// Provided Gradient to make sure the labels
    /// appear clearly over the poster imageview.
    override func awakeFromNib() {
        super.awakeFromNib()
        let gradient = CAGradientLayer()
        gradient.frame = posterContainerView.bounds
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        posterContainerView.layer.insertSublayer(gradient, at: 0)
    }
}
