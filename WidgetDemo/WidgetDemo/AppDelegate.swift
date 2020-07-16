//
//  AppDelegate.swift
//  WidgetDemo
//
//  Created by Piyush Chopra on 06/07/20.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    let networkManager = NetworkManager()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
//        let url = "http://api.icndb.com/jokes/random/10/"
//
//        networkManager.fetchData(url) { responseData in
//            print("wgwG")
//            guard let rawArray = responseData["value"] as? [[String: Any]] else {
//                return
//            }
////
//            let date = Date()
//            let calendar = Calendar.current
//
//
//            let entries = rawArray.enumerated().map { offset, currentJoke in
//                print (currentJoke)
//                JokesEntry(date: calendar.date(byAdding: .second, value: offset*2, to: date)!,
//                           joke: currentJoke["joke"] as? String ?? "N.A.")
//            }
//
//            let timeline = Timeline(entries: entries, policy: .after(refreshDate))
//            completion(timeline)
//        }

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}
