//
//  NotificationManager.swift
//  brewd
//
//  Created by mxa on 22.02.16.
//  Copyright © 2016 mxa. All rights reserved.
//

import Foundation.NSUserNotification

class NotificationManager: NSObject {
    let notificationCenter = NSUserNotificationCenter.default

    override init() {
        super.init()
//        self.notificationCenter.delegate = self
    }

    func show(message: String, replacingOthers: Bool = false) {
        let notification = NSUserNotification()
        notification.title = "Display Energy"
        notification.informativeText = message
        notification.hasActionButton = false
//        notification.actionButtonTitle = "Oh noes!"
//        notification.otherButtonTitle = "Close"

//        // Caution: Private API
//        let beer = BeerImage(size: NSSize(width: 30, height: 30))
//        notification.setValue(beer, forKey: "_identityImage")
//        notification.setValue(false, forKey: "_identityImageHasBorder")
        
        // Force show!
        notification.setValue(true, forKey: "_ignoresDoNotDisturb")
//        notification.setValue(false, forKey: "_showsButtons")
        
        if replacingOthers {
            self.notificationCenter.removeAllDeliveredNotifications()
        }

        self.notificationCenter.deliver(notification)
    }
    
    func clearAll() {
        self.notificationCenter.removeAllDeliveredNotifications()
    }
}


//// MARK: - NSUserNotificationCenterDelegate
//extension NotificationManager: NSUserNotificationCenterDelegate {
//    func userNotificationCenter(_ center: NSUserNotificationCenter, shouldPresent notification: NSUserNotification) -> Bool {
//        return true
//    }
//
////    func userNotificationCenter(_ center: NSUserNotificationCenter, didDeliver notification: NSUserNotification) {
////        print("Notification delivered:", notification.informativeText ?? "[no message]")
////    }
////
////    func userNotificationCenter(_ center: NSUserNotificationCenter, didActivate notification: NSUserNotification) {
////        print("Notification activated:", notification.informativeText ?? "[no message]")
////    }
//}
