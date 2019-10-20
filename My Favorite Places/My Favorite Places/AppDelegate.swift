//
//  AppDelegate.swift
//  My Favorite Places
//
//  Created by Olha Skulska on 2019. 10. 19..
//  Copyright © 2019. Olha Skulska. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
     lazy var coreDataStack = CoreDataStack()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().barTintColor = .systemGreen
        
        if let barFont = UIFont(name: "AppleSDGothicNeo-Regular", size: 24){
            let attributes: [NSAttributedString.Key: Any] = [
                .font: barFont,
                .foregroundColor: UIColor.white,
            ]
            UINavigationBar.appearance().titleTextAttributes = attributes
            
        }
        
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

