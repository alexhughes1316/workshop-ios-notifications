//
//  ViewController.swift
//  NotificationSample
//
//  Created by Alex Hughes on 2016-11-27.
//  Copyright © 2016 Digiflare Inc. All rights reserved.
//

import UIKit
import UserNotifications

// MARK: - Enums

private enum Category {
    
    case card
    
    var identifier: String {
        switch self {
        case .card:
            return "card"
        }
    }
    
    func makeNotificationCategory() -> UNNotificationCategory {
        switch self {
        case .card:
            return UNNotificationCategory(identifier: identifier, actions: [], intentIdentifiers: [], options: [])
        }
    }
}

// MARK: - Constants

private struct Constants {
    
    struct Notification {
        
        struct Attachment {
            static let localImage = "LocalImageAttachment"
        }
        
        struct Identifier {
            static let basic = "basicIdentifier"
        }
        
        struct Message {
            static let sample = NSString.localizedUserNotificationString(forKey: "DefaultMessage", arguments: nil)
        }
    }
}

final class ViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet private weak var titleTextField: UITextField!

    @IBOutlet private weak var subtitleTextField: UITextField!
    
    @IBOutlet private weak var bodyTextView: UITextView!
    
    @IBOutlet weak var scheduleStepper: UIStepper!
    
    @IBOutlet private weak var scheduleLabel: UILabel!
    
    private lazy var userNotificationCenter: UNUserNotificationCenter = {
        let userNotificationCenter = UNUserNotificationCenter.current()
        
        // Register categories
        let categories: [Category] = [.card]
        
        let notificationCategorySet = Set(categories.map({ $0.makeNotificationCategory() }))
        
        userNotificationCenter.setNotificationCategories(notificationCategorySet)
        
        return userNotificationCenter
    }()
    
    private let currentCategory: Category = .card
    
    private var currentNotificationContent: UNNotificationContent {
        return UNMutableNotificationContent(title: titleTextField.text,
                                            subtitle: subtitleTextField.text,
                                            body: bodyTextView.text,
                                            category: currentCategory)
    }
    
    private var defaultNotificationContent: UNNotificationContent {
        return UNMutableNotificationContent(title: nil, subtitle: nil, body: nil, category: currentCategory)
    }
    
    // MARK: - Methods
    
    private func scheduleNotification(for content: UNNotificationContent) {
        
        // Schedule trigger based on time interval
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: scheduleStepper.value, repeats: false)
        
        let request = UNNotificationRequest(identifier: Constants.Notification.Identifier.basic,
                                            content: content,
                                            trigger: trigger)
        
        userNotificationCenter.add(request) { error in
            if let error = error {
                NSLog("Error scheduling notification request. Error: \(error.localizedDescription)")
                return
            }
            NSLog("Notification scheduled!")
        }
    }
    
    // MARK: - Actions
    
    @IBAction private func scheduleStepperValueChanged(_ sender: UIStepper) {
        scheduleLabel.text = "\(sender.value)s"
    }
    
    @IBAction private func submitButtonAction(_ sender: UIButton) {
        scheduleNotification(for: currentNotificationContent)
    }
    
    @IBAction private func updateButtonAction(_ sender: Any) {
        scheduleNotification(for: defaultNotificationContent)
    }
}

private extension UNMutableNotificationContent {
    
    convenience init(title: String?, subtitle: String?, body: String?, category: Category) {
        
        self.init()
        
        self.title    = sanitizedText(for: title)
        self.subtitle = sanitizedText(for: subtitle)
        self.body     = sanitizedText(for: body)
        
        self.categoryIdentifier = category.identifier
        
        self.sound    = UNNotificationSound.default()
        
        let imageName = Constants.Notification.Attachment.localImage
        if let image = UIImage(named: imageName), let imageAttachment = UNNotificationAttachment(identifier: imageName, image: image) {
            self.attachments = [imageAttachment]
        }
    }
    
    private func sanitizedText(for text: String?) -> String {
        return text ?? Constants.Notification.Message.sample
    }
}
