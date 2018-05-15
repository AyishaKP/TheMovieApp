//
//  Movie+Extensions.swift
//  TheMovieApp
//
//  Created by Ayisha on 15/05/18.
//  Copyright © 2018 Careem. All rights reserved.
//

import Foundation
import UIKit

extension Movie {
    
    enum Router: Requestable {
        case getMovieList
        var path: String {
            switch self {
            case .getMovieList:
                return "search/movie"
            }
        }
        var parameters: Parameters?  {
            switch self {
            case .getMovieList: return nil

        }
    }
    
}
