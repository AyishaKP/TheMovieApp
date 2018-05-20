//
//  ThemeManager.swift
//  TheMovieApp
//
//  Created by Ayisha on 19/05/18.
//  Copyright © 2018 Careem. All rights reserved.
//

import UIKit

class ThemeManager {

    static let shared: ThemeManager = ThemeManager()
    private init() {

    }
    /// customization for NavigationBar and TextField appearence
    func customizeAppearance() {
        UINavigationBar.appearance().backgroundColor = UIColor.black
        UINavigationBar.appearance().barTintColor = UIColor.black
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white,
                                                            .font: UIFont.latoFont(.bold, size: 16)!]
        UITextField.appearance().keyboardAppearance = .dark
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self])
            .defaultTextAttributes = [NSAttributedStringKey.foregroundColor.rawValue: UIColor.white]
    }
}
