//
//  Requestable+PromiseAPI.swift
//  TheMovieApp
//
//  Created by Ayisha on 14/05/18.
//  Copyright © 2018 Careem. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import PromiseKit
import ObjectMapper

extension Requestable {

    /**
    - Created success and failure blocks using PromiseKit.
    - Calling json request within the promise initializer to recieve the response.
     */
    func createRequest<T: BaseMappable>() -> Promise<T> {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true

        return Promise { (fulfil, reject) -> Void in
            requestJSON { (response: DataResponse<T>) in

                UIApplication.shared.isNetworkActivityIndicatorVisible = false

                guard response.error == nil else {
                    reject(response.error ?? ServiceError.unknownError)
                    return
                }

                guard let value = response.value else {
                    reject(ServiceError.unknownError)
                    return
                }

                fulfil(value)
            }
        }

    }
}
