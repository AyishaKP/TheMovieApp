//
//  UIFont+Extensions.swift
//  TheMovieApp
//
//  Created by Ayisha on 14/05/18.
//  Copyright © 2018 Careem. All rights reserved.
//

import UIKit

/// This extension consist of useful methods that can generate custom font
extension UIFont {

    /// Used to provide Lato font to the Labels
    public enum LatoFont: CustomStringConvertible {
        case light
        case regular
        case medium
        case bold
        case black

        public var description: String {
            var fontName: String = ""
            switch self {
            case .light: fontName = "Light"
            case .regular: fontName = "Regular"
            case .medium: fontName = "Medium"
            case .bold: fontName = "Bold"
            case .black: fontName = "Black"
            }
            return "Lato-" + fontName
        }
    }

    /// Used to call Lato font method programmatically
    class func latoFont(_ fontType: LatoFont, size: CGFloat) -> UIFont? {
        return UIFont(name: fontType.description, size: size)
    }
}
