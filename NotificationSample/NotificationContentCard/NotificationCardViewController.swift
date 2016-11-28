//
//  NotificationCardViewController.swift
//  NotificationContentCard
//
//  Created by Alex Hughes on 2016-11-28.
//  Copyright © 2016 Digiflare Inc. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

final class NotificationCardViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var subtitleLabel: UILabel!
    
    @IBOutlet weak var bodyLabel: UILabel!
}

// MARK: - UNNotificationContentExtension

extension NotificationCardViewController: UNNotificationContentExtension {
    
    final func didReceive(_ notification: UNNotification) {
        let content = notification.request.content
        
        titleLabel.text    = content.title
        subtitleLabel.text = content.subtitle
        bodyLabel.text     = content.body
        
        // Image Attachment: Maintained by system, must explicitly make it accessible by the current process
        if let attachment = content.attachments.first {
            if attachment.url.startAccessingSecurityScopedResource() {
                imageView.image = UIImage(contentsOfFile: attachment.url.path)
                attachment.url.stopAccessingSecurityScopedResource()
            }
        }
    }
}
