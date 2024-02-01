//
//  Notification++.swift
//  Weather
//
//  Created by Bilal Bakhrom on 16/04/2022.
//

import Foundation
import Combine

extension NotificationCenter {
    public func post(appNotif notification: AppNotification, object anObject: Any? = nil) {
        post(name: notification.name, object: anObject)
    }
    
    public func publisher(appNotif notification: AppNotification) -> Publisher {
        publisher(for: notification.name)
    }
}
