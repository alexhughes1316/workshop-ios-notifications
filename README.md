# workshop-ios-notifications

## Overview
The objective of this application is to learn the following:

- How do we submit and handle user notifications in iOS 10 (since [UILocalNotification](https://developer.apple.com/reference/uikit/uilocalnotification) is now deprecated)?
- What new notification-based features have been introduced?
- What are [App Extensions](https://developer.apple.com/library/content/documentation/General/Conceptual/ExtensibilityPG/index.html) in iOS, and why we should use them?

## Pre-requisites
- Xcode 8.1

## Resources
- [UserNotifications.Framework](https://developer.apple.com/reference/usernotifications)
- [UNNotificationContentExtension](https://developer.apple.com/reference/usernotificationsui/unnotificationcontentextension)
- [UNNotificationServiceExtension](https://developer.apple.com/reference/usernotifications/unnotificationserviceextension)
- ["App Extension Essentials"](https://developer.apple.com/library/content/documentation/General/Conceptual/ExtensibilityPG/index.html#//apple_ref/doc/uid/TP40014214-CH20-SW1)

## Sample Implementation
Tags have been pushed to mark sample implementation for each task (e.g. ["Task 0"](https://github.com/alexhughes1316/workshop-ios-notifications/releases/tag/task-0))

Observing changes from one task to the next can be done using GitHub's compare view (e.g. [Task 0 - Task 1](https://github.com/alexhughes1316/workshop-ios-notifications/compare/task-0...task-1))

## Tasks

### 0. Project Setup / Authorization
Create a new Swift Xcode Project using the "Single View Application" iOS template

In `AppDelegate.swift`, request authorization to display **alerts**, **sounds**, and **badges**
<details><summary>Hint:</summary> [`UNUserNotificationCenter.requestAuthorization(options:completionHandler:)`](https://developer.apple.com/reference/usernotifications/unusernotificationcenter)
</details>

### 1. Time-triggered Local Notification
Add a button in `ViewController.swift`, which, when tapped, will deliver a local notification to the user after a specified amount of time
<details><summary>Hint:</summary>
```swift
let content = UNMutableNotificationContent()
content.title = NSString.localizedUserNotificationStringForKey("Hello!", arguments: nil)
content.body = NSString.localizedUserNotificationStringForKey("Hello_message_body", arguments: nil)
content.sound = UNNotificationSound.default() // Deliver the notification in five seconds.
let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
let request = UNNotificationRequest(identifier: "FiveSecond", content: content, trigger: trigger) // Schedule the notification.
let center = UNUserNotificationCenter.current()
center.add(request)
```
(Source: [UNUserNotificationCenter - "Listing 2"](https://developer.apple.com/reference/usernotifications/unusernotificationcenter))
</details>

Bonus: Add other `UIControl` elements to specify title / subtitle / time interval

### 2. Media Attachments
Add a local / remote image to appear alongside the scheduled local notification
<details><summary>Hint:</summary>
[`UNNotificationAttachment`](https://developer.apple.com/reference/usernotifications/unnotificationattachment) requires initialization via a `URL`, which "must be readable by the current process". When the notification is scheduled, the attachment data is moved to a separate location by the system, so the recommended solution is to save the asset to the user's temporary directory (See: [Stack Overflow Solution](http://stackoverflow.com/questions/39103095/unnotificationattachment-with-uiimage-or-remote-url)).
</details>

### 3. Foreground Local Notification
Allow the notification to be presented to the user, if it is delivered while the application is in the foreground
<details><summary>Hint:</summary>[`UNUserNotificationCenterDelegate.userNotificationCenter(_:willPresent:withCompletionHandler:)`](https://developer.apple.com/reference/usernotifications/unusernotificationcenterdelegate/1649518-usernotificationcenter)
</details>

### 4. Update Scheduled / Delivered Notification
Add a button, which, when tapped, will update the previously submitted notification to some predefined static text

### 5. Localized Notification
Add a button, which, when tapped, will submit a localized notification message
<details><summary>Hint:</summary>
While `NSLocalizedString` works, what if the user changes their device locale before the notification is delivered?
</details>

### 6. Custom Notification UI
[Create an App Extension](https://developer.apple.com/library/content/documentation/General/Conceptual/ExtensibilityPG/ExtensionCreation.html#//apple_ref/doc/uid/TP40014214-CH5-SW1) to present a custom notification interface, displaying the title, subtitle, image attachment, and custom data:
<details><summary>Hint:</summary>

- App Extension: [`UNNotificationContentExtension`](https://developer.apple.com/reference/usernotificationsui/unnotificationcontentextension) 

- Register a notification category with an identifier that matches the `UNNotificationExtensionCategory` value in the app extension's `Info.plist` ([`UNUserNotificationCenter.setNotificationCategories(_:)`](https://developer.apple.com/reference/usernotifications/unusernotificationcenter/1649512-setnotificationcategories))

- When scheduling a local notification, include the appropriate category identifier string in the notification’s content ([`UNNotificationContent.categoryIdentifier`](https://developer.apple.com/reference/usernotifications/unnotificationcontent/1649866-categoryidentifier))
</details>

### 7. Custom Notification Actions
Present another custom notification interface, this one with actions that alter the state of the UI
   
- Example: Display a view which is scaled / rotated when an action is selected (using [`UIViewPropertyAnimator`](https://developer.apple.com/reference/uikit/uiviewpropertyanimator), iOS 10+)

<details><summary>Hint:</summary>
You can have more than one notification content extension (just make sure you register it with a different category identifier)
</details>

## Further Enhancements
- Support remote notifications!
   - Can re-use the custom interface extensions made for local notifications
   - [`UNNotificationServiceExtension`](https://developer.apple.com/reference/usernotifications/unnotificationserviceextension): Allows the developer to modify a remote notification before it is presented to the user (e.g. to [download an image](https://blog.pusher.com/how-to-send-ios-10-notifications-using-the-push-notifications-api/) associated with a URL in the notification payload)
