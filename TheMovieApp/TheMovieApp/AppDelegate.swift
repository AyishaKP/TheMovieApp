//
//  AppDelegate.swift
//  TheMovieApp
//
//  Created by Ayisha on 14/05/18.
//  Copyright © 2018 Careem. All rights reserved.
//

import UIKit
import SwiftyBeaver

/// This class is used to receive application-level messages and gives a chance to respond to different app life cycle events.
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    /// This variable points to the key window for the application.
    var window: UIWindow?

    /// Sent when the application launch process is almost done and the app is almost ready to run.
    func application(_ application: UIApplication, didFinishLaunchingWithOptions
                        launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        /// Instantiate the reachability manager to observe for connectivty.
        NetworkManager.shared.startNetworkReachabilityObserver()
        
        /// Instantiate the theme for the app.
        ThemeManager.shared.customizeAppearance()
        
        /// Configuring Swifty Beaver to work only in debug mode.
        #if DEBUG
            SwiftyBeaver.addDestination(ConsoleDestination())
        #endif

        return true
    }

    /// Sent when the application is about to move from active to inactive state.
    /// This can occur for certain types of temporary interruptions (such as an incoming
    /// phone call or SMS message) or when the user quits the application
    /// and it begins the transition to the background state.
    /// Use this method to pause ongoing tasks, disable timers,
    /// and invalidate graphics rendering callbacks. Games should
    /// use this method to pause the game.
    func applicationWillResignActive(_ application: UIApplication) {
        
    }

    /// Use this method to release shared resources, save user data, invalidate timers,
    /// and store enough application state information to restore your application
    /// to its current state in case it is terminated later.
    /// If your application supports background execution, this method
    /// is called instead of applicationWillTerminate: when the user quits.
    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }

    /// Called as part of the transition from the background to the active state;
    /// here you can undo many of the changes made on entering the background.
    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }

    /// Restart any tasks that were paused (or not yet started) while
    /// the application was inactive. If the application was previously in the background,
    /// optionally refresh the user interface.
    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }

    /// Called when the application is about to terminate. Save data if appropriate.
    /// See also applicationDidEnterBackground:.
    func applicationWillTerminate(_ application: UIApplication) {
        
    }

}
