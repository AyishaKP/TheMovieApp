//
//  NetworkManager.swift
//  TheMovieApp
//
//  Created by Ayisha on 16/05/18.
//  Copyright © 2018 Careem. All rights reserved.
//

import Alamofire
import SwiftyBeaver

/// This class will let us know about the network reachability.
final class NetworkManager {

    /// Singleton Instance
    static let shared = NetworkManager()

    /// Access to initializer restricted.
    private init() {

    }

    /// Reachability manager instantiated using the server path.
    private let reachabilityManager = Alamofire.NetworkReachabilityManager(host: "api.themoviedb.org")

    /// Variable that is updated when connectivity changes and
    /// can tell if the server is reachable or not.
    var isReachable: Bool = false

    /// Method to check Network reachability
    func startNetworkReachabilityObserver() {

        reachabilityManager?.listener = { status in
            switch status {

            case .notReachable:
                self.isReachable = false
                SwiftyBeaver.debug("The network is not reachable")

            case .unknown :
                self.isReachable = false
                SwiftyBeaver.debug("It is unknown whether the network is reachable")

            case .reachable(.ethernetOrWiFi):
                self.isReachable = true
                SwiftyBeaver.debug("The network is reachable over the WiFi connection")

            case .reachable(.wwan):
                self.isReachable = true
                SwiftyBeaver.debug("The network is reachable over the WWAN connection")

            }
        }

        /// start listening
        reachabilityManager?.startListening()
    }
}
