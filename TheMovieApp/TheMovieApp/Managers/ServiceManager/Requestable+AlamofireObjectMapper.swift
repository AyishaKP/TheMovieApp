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

/**
- Default implementation of Requestable protocol.
- Can implement these variables and methods
  in enum, class or struct that implements Requestable protocol.
 */
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
    /**
    - Implement this method to initiate a web service call using alamofire request.
    - validateResponse call will validate all the errors in the response.
    - responseObject method is used by object mapper to map to the generic model passed.
    - Will handle json response serialization.
     */
    @discardableResult func requestJSON<T: BaseMappable>
        (with objectCompletion:@escaping (DataResponse<T>) -> Void) -> DataRequest {
       return RequestManager.shared.manager.request(self)
        .validateResponse()
        .responseObject(completionHandler: objectCompletion)
    }

    /**
     - Implement this method to initiate a web service call using alamofire request.
     - validateResponse call will validate all the errors in the response.
     - responseArray method is used by object mapper to map to the generic model passed.
     - Will handle json response serialization.
     */
    @discardableResult func requestJSON<T: BaseMappable>
        (with arrayCompletion:@escaping (DataResponse<[T]>) -> Void) -> DataRequest {
        return RequestManager.shared.manager.request(self)
            .validateResponse()
            .responseArray(completionHandler: arrayCompletion)
    }

    /**
     - Implement this method to initiate a web service call using alamofire request.
     - validateResponse call will validate all the errors in the response.
     - responseXMLToJsonObject method is used by object mapper
       to map to the generic model passed.
     - Will handle json response serialization.
     */
    @discardableResult func requestXML<T: BaseMappable>
        (with objectCompletion:@escaping (DataResponse<T>) -> Void) -> DataRequest {
        return RequestManager.shared.manager.request(self)
            .validateResponse()
            .responseXMLToJsonObject(completionHandler: objectCompletion)
    }

    /// Created request based on all the parameters.
    func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        var finalParameters = parameters
        finalParameters?.updateValue(apiKey, forKey: "api_key")
        return try encoding.encode(urlRequest, with: finalParameters)

    }
}
