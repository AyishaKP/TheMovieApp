//
//  Movie+Router.swift
//  TheMovieApp
//
//  Created by Ayisha on 15/05/18.
//  Copyright © 2018 Careem. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

extension Movie {

    /// Router implemements Requestable to customize different URL request attributes.
    enum Router: Requestable {
        case search(_: String, page: Int)
        static let imageUrl: String = "http://image.tmdb.org/t/p/w780/"
        var path: String {
            switch self {
            case .search:
                return "/search/movie"
            }
        }
        var method: Alamofire.HTTPMethod {
            switch self {
            case .search:
                return .get
            }
        }
        var parameters: Parameters? {
            switch self {
            case .search(let query, let page):
                return ["query": query, "page": page]
            }
        }
        var encoding: ParameterEncoding {
            switch self {
            case .search:
                return URLEncoding.default
            }
        }

    }
}
