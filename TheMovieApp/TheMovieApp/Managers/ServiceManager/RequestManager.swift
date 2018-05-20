//
//  RequestManager.swift
//  TheMovieApp
//
//  Created by Ayisha on 20/05/18.
//  Copyright © 2018 Careem. All rights reserved.
//

import Alamofire
import PromiseKit

final class RequestManager {

    /// Singleton Instance
    static let shared: RequestManager = RequestManager()

    var manager: Alamofire.SessionManager

    /// Access to initializer restricted.
    private init() {
        manager = Alamofire.SessionManager()
    }
}
