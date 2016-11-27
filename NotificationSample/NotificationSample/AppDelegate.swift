//
//  AppDelegate.swift
//  NotificationSample
//
//  Created by Alex Hughes on 2016-11-27.
//  Copyright © 2016 Digiflare Inc. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // Request authorization to display alerts, sounds, badges
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            guard granted else {
                NSLog("User notifications were not authorized. Error: \(error?.localizedDescription ?? "")")
                return
            }
            NSLog("User notifications authorized.")
        }
        
        return true
    }
}
