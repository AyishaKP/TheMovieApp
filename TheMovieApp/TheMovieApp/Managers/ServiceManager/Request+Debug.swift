//
//  Request+Debug.swift
//  TheMovieApp
//
//  Created by Ayisha on 14/05/18.
//  Copyright © 2018 Careem. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyBeaver

enum ServiceError: Error {
    case unknownError
    case connectionError
    case notFound
    case invalidResponse
    case timeOut

    var localizedDescription: String {
        switch self {
        case .unknownError:
            return "Sorry, something went wrong!"
        default: return "Sorry, something went wrong!"
        }
    }
}

public extension Alamofire.Request {

    typealias Log = SwiftyBeaver

    @discardableResult func debug() -> Self {
        Log.info(debugDescription)
        return self
    }
}
public extension Alamofire.DataRequest {

    @discardableResult
    func validateResponse() -> Self {
        return self.validate({ [weak self] (request, response, data) -> Alamofire.Request.ValidationResult in

            // get status code from server
            let code = response.statusCode

            // check the request url
            let requestURL = String(describing: request?.url?.absoluteString ?? "NO URL")

            // check if response is empty
            guard let data = data, let string = String(data: data, encoding: .utf8) else {
                Log.warning(String(code) + " " + requestURL + "\nEmpty response")
                return .failure(ServiceError.invalidResponse)
            }

            var result: Alamofire.Request.ValidationResult = .success

            // check if response is html
            if (response.allHeaderFields["Content-Type"] as? String)?.contains("text/html") == true {
                Log.info(String(code) + " " + requestURL + "\n\(string)")
                result = .failure(ServiceError.invalidResponse)
            } else {
                Log.info(String(code) + " " + requestURL + "\n\(string)")
                if code != 200 {
                    guard let weakSelf = self else {
                        result = .failure(ServiceError.unknownError)
                        return result
                    }
                    result = .failure(weakSelf.checkErrorCode(code))
                } else {
                    result = .success
                }
            }
            return result
        }).validate().debug()
    }

    private func checkErrorCode(_ errorCode: Int) -> ServiceError {
        switch errorCode {
        case 404:
            return .notFound
        default:
            return .unknownError
        }
    }
}
