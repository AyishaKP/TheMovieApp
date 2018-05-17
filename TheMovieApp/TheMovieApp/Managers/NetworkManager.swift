//
//  NetworkManager.swift
//  TheMovieApp
//
//  Created by Ayisha on 16/05/18.
//  Copyright © 2018 Careem. All rights reserved.
//

import Alamofire

class NetworkManager {

    //shared instance
    static let shared = NetworkManager()

    let reachabilityManager = Alamofire.NetworkReachabilityManager(host: "api.themoviedb.org")
    var isReachable: Bool = false
    func startNetworkReachabilityObserver() {

        reachabilityManager?.listener = { status in
            switch status {

            case .notReachable:
                self.isReachable = false
                print("The network is not reachable")

            case .unknown :
                self.isReachable = false
                print("It is unknown whether the network is reachable")

            case .reachable(.ethernetOrWiFi):
                self.isReachable = true
                print("The network is reachable over the WiFi connection")

            case .reachable(.wwan):
                self.isReachable = true
                print("The network is reachable over the WWAN connection")

            }
        }
        // start listening
        reachabilityManager?.startListening()
    }
}
