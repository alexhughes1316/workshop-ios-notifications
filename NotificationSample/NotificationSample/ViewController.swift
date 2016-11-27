//
//  ViewController.swift
//  NotificationSample
//
//  Created by Alex Hughes on 2016-11-27.
//  Copyright © 2016 Digiflare Inc. All rights reserved.
//

import UIKit
import UserNotifications

final class ViewController: UIViewController {
    
    // MARK: - Constants
    
    private struct Constants {
        
        struct Notifications {
            
            struct Identifier {
                static let basic = "basicIdentifier"
            }
            
        }
    }
    
    // MARK: - Properties
    
    @IBOutlet private weak var titleTextField: UITextField!

    @IBOutlet private weak var subtitleTextField: UITextField!
    
    @IBOutlet private weak var bodyTextView: UITextView!
    
    @IBOutlet weak var scheduleStepper: UIStepper!
    
    @IBOutlet private weak var scheduleLabel: UILabel!
    
    private let userNotificationCenter: UNUserNotificationCenter = UNUserNotificationCenter.current()
    
    // MARK: - Methods
    
    private func makeNotificationContent() -> UNNotificationContent {
        
        let content = UNMutableNotificationContent()
        
        content.title    = titleTextField.text ?? ""
        content.subtitle = subtitleTextField.text ?? ""
        content.body     = bodyTextView.text
        content.sound    = UNNotificationSound.default()
        
        return content
    }
    
    private func scheduleNotification() {
        
        // Schedule trigger based on time interval
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: scheduleStepper.value, repeats: false)
        
        let request = UNNotificationRequest(identifier: Constants.Notifications.Identifier.basic,
                                            content: makeNotificationContent(),
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
        scheduleNotification()
    }
}
