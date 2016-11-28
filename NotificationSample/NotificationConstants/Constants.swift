//
//  Constants.swift
//  NotificationConstants
//
//  Created by Alex Hughes on 2016-11-28.
//  Copyright © 2016 Digiflare Inc. All rights reserved.
//

import Foundation
import UserNotifications

public struct Constants {
    
    public struct Notification {
        
        public struct Action {
            public static let pause     = "pause"
            public static let reset     = "reset"
            public static let transform = "transform"
        }
        
        public struct Attachment {
            public static let localImage = "LocalImageAttachment"
        }
        
        public struct Category {
            public static let animation = "animation"
            public static let card      = "card"
        }
        
        public struct Identifier {
            public static let basic = "basicIdentifier"
        }
        
        public struct Message {
            public static let sample = NSString.localizedUserNotificationString(forKey: "DefaultMessage", arguments: nil)
        }
    }
}
