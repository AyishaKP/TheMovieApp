//
//  UIColor+Extensions.swift
//  TheMovieApp
//
//  Created by Ayisha on 14/05/18.
//  Copyright © 2018 Careem. All rights reserved.
//

import UIKit

extension UIColor {

    // Use to create a black color with transparency which is applied to
    // background of a text to make it more visible
    static let transparentBlack = UIColor(hex: 0x000000, alpha: 0.5)

    // Used to provide border of a movie cell
    static let swanWhite = UIColor(red: 247, green: 241, blue: 227)

    // Used to provide button background
    static let darkRed = UIColor(red: 179, green: 57, blue: 57)

    // Create a UIColor from RGB
    convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: alpha
        )
    }

    // Create a UIColor from a hex value (E.g 0x000000)
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        self.init(
            red: (hex >> 16) & 0xFF,
            green: (hex >> 8) & 0xFF,
            blue: hex & 0xFF,
            alpha: alpha
        )
    }
}
