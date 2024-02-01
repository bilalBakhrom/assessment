//
//  AppNotification.swift
//  WeatherFit
//
//  Created by Bilal Bakhrom on 16/04/2022.
//

import SwiftUI

public typealias AppNotificationOutput = NotificationCenter.Publisher.Output
public typealias AppNotificationCompletion = (AppNotificationOutput) -> Void

public protocol AppNotificationName {
    var name: Notification.Name { get }
}

extension AppNotificationName where Self: RawRepresentable, RawValue == String {
    public var name: Notification.Name { .init(rawValue) }
}

public enum AppNotification: String, AppNotificationName {
    case didChangeApp
    
    public var key: String { rawValue }
}
