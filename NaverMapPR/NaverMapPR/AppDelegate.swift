//
//  AppDelegate.swift
//  NaverMapPR
//
//  Created by 이건준 on 2022/05/06.
//

import UIKit
import NMapsMap

@main
class AppDelegate: UIResponder, UIApplicationDelegate, NMFAuthManagerDelegate {
    func authorized(_ state: NMFAuthState, error: Error?) {
        
//        print("state = \(state)")
//        print("error = \(error)")
    }
    



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        NMFAuthManager.shared().clientId = "2z684h5hop"
        NMFAuthManager.shared().delegate = self
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

