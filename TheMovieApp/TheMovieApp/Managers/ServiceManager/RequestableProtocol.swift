//
//  RequestableProtocol.swift
//  TheMovieApp
//
//  Created by Ayisha on 14/05/18.
//  Copyright © 2018 Careem. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

protocol Requestable: URLRequestConvertible {
    var method: Alamofire.HTTPMethod { get }
    var `protocol`: String { get }
    var baseUrl: String { get }
    var pathType: String { get }
    var path: String { get }
    var apiKey: String { get }
    var url: URL { get }
    var parameters: Parameters { get }

    @discardableResult func call<T: BaseMappable>
        (with responseObject:@escaping (DataResponse<T>) -> Void) -> DataRequest
    @discardableResult func call<T: BaseMappable>
        (with responseArray:@escaping (DataResponse<[T]>) -> Void) -> DataRequest
}
