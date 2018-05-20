//
//  MovieTableViewCell.swift
//  TheMovieApp
//
//  Created by Ayisha on 14/05/18.
//  Copyright © 2018 Careem. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleNameLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overViewLabel: UILabel!
    @IBOutlet weak var posterContainerView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        posterImageView.clipsToBounds = true
        /*
        - Provided Gradient to make sure the labels
        - to appear clearly over the poster imageview
         */
        let gradient = CAGradientLayer()
        gradient.frame = posterContainerView.bounds
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        posterContainerView.layer.insertSublayer(gradient, at: 0)
    }
}
