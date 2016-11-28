//
//  UNNotificationAttachment+ImageExtensions.swift
//  NotificationSample
//
//  Created by Alex Hughes on 2016-11-27.
//  Copyright © 2016 Digiflare Inc. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications

// Source: http://stackoverflow.com/questions/39103095/unnotificationattachment-with-uiimage-or-remote-url
extension UNNotificationAttachment {

    /// Constructs an attachment by writing a given `UIImage` into the temporary directory
    ///
    /// - Parameter identifier: The unique identifier of the attachment.
    /// - Parameter image: The `UIImage` associated with the attachment
    convenience init?(identifier: String, image: UIImage) {
        
        let fileManager = FileManager.default
        let tmpSubFolderName = ProcessInfo.processInfo.globallyUniqueString
        let tmpSubFolderURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(tmpSubFolderName, isDirectory: true)
        
        do {
            try fileManager.createDirectory(at: tmpSubFolderURL, withIntermediateDirectories: true, attributes: nil)
            
            let imageFileIdentifier = "\(identifier).png"
            let fileURL = tmpSubFolderURL.appendingPathComponent(imageFileIdentifier)
            guard let imageData = UIImagePNGRepresentation(image) else {
                return nil
            }
            
            try imageData.write(to: fileURL)
            
            try self.init(identifier: imageFileIdentifier, url: fileURL, options: nil)
        }
        catch {
            return nil
        }
    }

}
