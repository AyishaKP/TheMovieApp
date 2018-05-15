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
    var deployment: String {
        return "3"
    }
    var url: URL {
        guard let url = URL(string: "\(`protocol`)://\(baseUrl)/\(deployment)")
            else { fatalError("The url to call the Server is not configured") }
        return url
    }
    var apiKey: String {
        return "2696829a81b1b5827d515ff121700838"
    }
    var method: Alamofire.HTTPMethod {
        return .get
    }
    func call<T>(with responseObjectCompletionHandler: @escaping (DataResponse<T>) -> Void)
        -> DataRequest where T: BaseMappable {
       return Alamofire.request(self).validate().responseObject(completionHandler: responseObjectCompletionHandler)
    }
    func call<T>(with responseArrayCompletionHandler: @escaping (DataResponse<[T]>) -> Void)
        -> DataRequest where T: BaseMappable {
        return Alamofire.request(self).validate().responseArray(completionHandler: responseArrayCompletionHandler)
    }
    func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        var finalParameters = parameters
        finalParameters?.updateValue(apiKey, forKey: "api_key")
        return try encoding.encode(urlRequest, with: finalParameters)

    }
}
