//
//  Requestable+AlamofireObjectMapper.swift
//  TheMovieApp
//
//  Created by Ayisha on 14/05/18.
//  Copyright © 2018 Careem. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

extension Requestable {

    var `protocol`: String {
        return "http"
    }
    var baseUrl: String {
        return "api.themoviedb.org"
    }
    var path: String {
        return "3/search/movie"
    }
    var url: URL {
        return URL(string: "\(`protocol`)://\(baseUrl)/\(path)?") ?? URL(fileURLWithPath: "")
    }
    var method: Alamofire.HTTPMethod {
        return .get
    }
    func asURLRequest() throws -> URLRequest {
        let urlRequest = try URLRequest(url: url.appendingPathComponent(path), method: method)
        return try Alamofire.URLEncoding.default.encode(urlRequest, with: parameters)
    }
}
