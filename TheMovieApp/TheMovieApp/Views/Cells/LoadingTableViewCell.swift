//
//  LoadingTableViewCell.swift
//  TheMovieApp
//
//  Created by Ayisha on 20/05/18.
//  Copyright © 2018 Careem. All rights reserved.
//

import UIKit

class LoadingTableViewCell: UITableViewCell {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    @IBOutlet weak var loadingLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        loadingLabel.textColor = UIColor.swanWhite

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
