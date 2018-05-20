//
//  Requestable.swift
//  TheMovieApp
//
//  Created by Ayisha on 14/05/18.
//  Copyright © 2018 Careem. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

/// Protocol used to create a URL request and call a webservice.
protocol Requestable: URLRequestConvertible {

    /// Customizable URL Request Parameters
    var method: Alamofire.HTTPMethod { get }
    var `protocol`: String { get }
    var baseUrl: String { get }
    var deployment: String { get }
    var path: String { get }
    var apiKey: String { get }
    var url: URL { get }
    var parameters: Parameters? { get }
    var encoding: ParameterEncoding { get }

    /**
    - Implement this method to call to initiate alamofire request
      and get the response as a single base mappable model
      that is expected from a json response.
     */
    @discardableResult func requestJSON<T: BaseMappable>
        (with objectCompletion:@escaping (DataResponse<T>) -> Void) -> DataRequest

    /**
    - Implement this method to call to initiate alamofire request
      and get the response in an array of base mappable model
      that is expected from a json response.
     */
    @discardableResult func requestJSON<T: BaseMappable>
        (with arrayCompletion:@escaping (DataResponse<[T]>) -> Void) -> DataRequest

    /**
    - Implement this method to call to initiate alamofire request
      and get the response as a single base mappable model
      that is expected from a xml response data.
     */
    @discardableResult func requestXML<T: BaseMappable>
        (with objectCompletion: @escaping (DataResponse<T>) -> Void) -> DataRequest
}
