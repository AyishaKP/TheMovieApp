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
        enum Router: Requestable {
        case getMovieList(_: String, _: MovieHandler)
        var path: String {
            switch self {
            case .getMovieList:
                return "/search/movie"
            }
        }
        var method: Alamofire.HTTPMethod {
            switch self {
            case .getMovieList:
                return .get
                }
            }
        var parameters:Parameters?  {
            switch self {
            case .getMovieList(let query, let movieTitle):
                return ["query":query, "page":movieTitle.page]
                }
            }
        var encoding: ParameterEncoding {
            switch self {
            case .getMovieList:
                return URLEncoding.default
            default:
                return JSONEncoding.default
            }
        }
        
        func asURLRequest() throws -> URLRequest {
            var urlRequest = URLRequest(url: url.appendingPathComponent(path))
            urlRequest.httpMethod = method.rawValue
            return try encoding.encode(urlRequest, with: parameters)
            
            }
        }
    }


