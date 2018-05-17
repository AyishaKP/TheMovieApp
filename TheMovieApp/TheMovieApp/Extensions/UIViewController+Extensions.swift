//
//  UIViewController+Extensions.swift
//  TheMovieApp
//
//  Created by Ayisha on 16/05/18.
//  Copyright © 2018 Careem. All rights reserved.
//

import UIKit

extension UIViewController {

    //Created Alert controller for showing alerts
    func showAlert(message: String, title: String = "", okAction handler: ((UIAlertAction) -> Swift.Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: handler)
        alertController.addAction(OKAction)
        alertController.view.tintColor = UIColor.black
        self.present(alertController, animated: true, completion: nil)
    }
}
