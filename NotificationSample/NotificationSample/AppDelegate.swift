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
        let userNotificationCenter = UNUserNotificationCenter.current()
        userNotificationCenter.delegate = self
        
        userNotificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            guard granted else {
                NSLog("User notifications were not authorized. Error: \(error?.localizedDescription ?? "")")
                return
            }
            NSLog("User notifications authorized.")
        }
        
        return true
    }
}

// MARK: - UNUserNotificationCenterDelegate

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // Enable presentation of local notification while application is in the foreground
        completionHandler([.alert, .sound])
    }
}
