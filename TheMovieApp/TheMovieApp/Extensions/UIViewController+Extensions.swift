//
//  UIViewController+Extensions.swift
//  TheMovieApp
//
//  Created by Ayisha on 16/05/18.
//  Copyright © 2018 Careem. All rights reserved.
//

import UIKit

/// This extension consist of useful methods that can be used
// to show alerts in a UIViewController.
extension UIViewController {

    /// Show alert using an localised error messege
    func show(with error: Error, okAction handler: @escaping (UIAlertAction) -> Void) {
        showAlert(message: error.localizedDescription, title: "Error", okAction: handler)
    }

    /// Created alert controller for showing alerts
    func showAlert(message: String, title: String = "", okAction handler: @escaping (UIAlertAction) -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: handler)
        alertController.addAction(OKAction)
        alertController.view.tintColor = UIColor.black
        self.present(alertController, animated: true, completion: nil)
    }
}
