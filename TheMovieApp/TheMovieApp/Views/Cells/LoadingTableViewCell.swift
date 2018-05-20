//
//  LoadingTableViewCell.swift
//  TheMovieApp
//
//  Created by Ayisha on 20/05/18.
//  Copyright © 2018 Careem. All rights reserved.
//

import UIKit

/// This cell is used to show a loading indicator when a new page is being loaded.
class LoadingTableViewCell: UITableViewCell {

    /// Activity indicator will need to be animated when the cell is displayed.
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    /// loading label will have the loading title
    @IBOutlet weak var loadingLabel: UILabel!

    /// makes simple UI customizations
    override func awakeFromNib() {
        super.awakeFromNib()
        loadingLabel.textColor = UIColor.swanWhite
    }
}
