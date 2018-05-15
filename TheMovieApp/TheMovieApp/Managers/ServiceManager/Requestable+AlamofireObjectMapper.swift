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
    var pathType: String {
        return "3"
    }
    var url: URL {
        return URL(string: "\(`protocol`)://\(baseUrl)/\(pathType)") ?? URL(fileURLWithPath: "")
    }
    var apiKey: String {
        return "2696829a81b1b5827d515ff121700838"
    }
    var method: Alamofire.HTTPMethod {
        return .get
    }
//    func call<T>(with responseObject: @escaping (DataResponse<T>) -> Void) -> DataRequest where T : BaseMappable {
//       return
//    }
//    
//    func call<T>(with responseArray: @escaping (DataResponse<[T]>) -> Void) -> DataRequest where T : BaseMappable {
//        return
//    }
//    func asURLRequest() throws -> URLRequest {
//        let urlRequest = try URLRequest(url: url.appendingPathComponent(path), method: method)
//        return try Alamofire.URLEncoding.default.encode(urlRequest, with: parameters)
//    }
}
