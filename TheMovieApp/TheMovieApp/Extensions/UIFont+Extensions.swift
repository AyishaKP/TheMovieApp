//
//  UIFont+Extensions.swift
//  TheMovieApp
//
//  Created by Ayisha on 14/05/18.
//  Copyright © 2018 Careem. All rights reserved.
//

import UIKit

extension UIFont {

    enum LatoFont: CustomStringConvertible {
        case light
        case regular
        case medium
        case bold
        case black
        var description: String {
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
        class func latoFont(_ fontType: LatoFont, size: CGFloat) -> UIFont? {
            return UIFont(name: fontType.description, size: size)
        }
}
