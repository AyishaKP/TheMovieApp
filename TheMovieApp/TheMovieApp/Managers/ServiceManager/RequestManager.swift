//
//  RequestManager.swift
//  TheMovieApp
//
//  Created by Ayisha on 20/05/18.
//  Copyright © 2018 Careem. All rights reserved.
//

import Alamofire
import PromiseKit

/**
 This class will create an instance of alamofire session manager
 and can be used to customize the manager.
 */
final class RequestManager {

    /// Singleton Instance
    static let shared: RequestManager = RequestManager()

    /// The alamofie manager used to send requests to the server and handle the response.
    var manager: Alamofire.SessionManager

    /// Access to initializer restricted.
    private init() {
        manager = Alamofire.SessionManager()
    }
}
