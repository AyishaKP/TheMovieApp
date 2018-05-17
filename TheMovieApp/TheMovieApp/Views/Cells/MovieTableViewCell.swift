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
//        posterImageView.contentMode = .scaleAspectFill
        posterImageView.clipsToBounds = true
        posterImageView.backgroundColor = UIColor.transparentBlack

        let gradient = CAGradientLayer()

        gradient.frame = posterContainerView.bounds
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]

        posterContainerView.layer.insertSublayer(gradient, at: 0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
