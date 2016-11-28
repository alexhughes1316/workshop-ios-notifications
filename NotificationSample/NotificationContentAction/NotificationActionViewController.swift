//
//  NotificationActionViewController.swift
//  NotificationContentAction
//
//  Created by Alex Hughes on 2016-11-28.
//  Copyright © 2016 Digiflare Inc. All rights reserved.
//

import NotificationConstants

import UIKit
import UserNotifications
import UserNotificationsUI

final class NotificationActionViewController: UIViewController {

    // MARK: - Constants
    
    struct Animation {
        static let duration: TimeInterval = 1.0
        static let scale: CGFloat         = 2.0
        static let rotation: CGFloat      = CGFloat.pi
    }
    
    // MARK: - Properties
    
    @IBOutlet weak var spriteView: UIView!
    
    let animator: UIViewPropertyAnimator = UIViewPropertyAnimator(duration: Animation.duration, curve: .easeInOut)
}

// MARK: - UNNotificationContentExtension

extension NotificationActionViewController: UNNotificationContentExtension {
    
    final func didReceive(_ notification: UNNotification) {
        // Ignore properties of notification
    }
    
    final func didReceive(_ response: UNNotificationResponse, completionHandler completion: @escaping (UNNotificationContentExtensionResponseOption) -> Swift.Void) {
        
        switch response.actionIdentifier {
        case Constants.Notification.Action.pause:
            pause()
        case Constants.Notification.Action.transform:
            transform()
        case Constants.Notification.Action.reset:
            reset()
        default:
            break
        }
        
        // Retain UI
        completion(.doNotDismiss)
    }
    
    // MARK: - Private Methods
    
    private func pause() {
        animator.pauseAnimation()
    }
    
    private func transform() {
        animator.addAnimations { [weak self] in
            var transform: CGAffineTransform = .identity
            
            transform = transform.scaledBy(x: Animation.scale, y: Animation.scale)
            transform = transform.rotated(by: Animation.rotation)
            
            self?.spriteView.transform = transform
        }
        animator.startAnimation()
    }
    
    private func reset() {
        if animator.isRunning {
            animator.isReversed = true
            return
        }
        
        animator.addAnimations { [weak self] in
            self?.spriteView.transform = .identity
        }
        animator.startAnimation()
    }
}
