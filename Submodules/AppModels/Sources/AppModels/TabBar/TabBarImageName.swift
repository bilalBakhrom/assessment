//
//  TabBarImageName.swift
//
//
//  Created by Bilal Bakhrom on 2024-02-01.
//

import SwiftUI
import AppFoundation
import AppAssets

/// Represents the name of a tab bar image, which can be either a system image or a local asset image.
public struct TabBarImageName: ExpressibleByStringLiteral {
    /// The value of the image name.
    public let value: String
    
    /// Indicates whether the image is a system image.
    private var isSystemImage: Bool = false
    
    /// Indicates whether the image is a app icon.
    private var isAppIcon: Bool = false
    
    /// Initializes a `TabBarImageName` with a string literal.
    ///
    /// - Parameter value: The value of the image name.
    public init(stringLiteral value: String) {
        self.value = value
    }
    
    /// Initializes a `TabBarImageName` with a system image name.
    ///
    /// - Parameter systemName: The name of the system image.
    public init(systemName value: String) {
        self.value = value
        self.isSystemImage = true
    }
    
    /// Initializes a `TabBarImageName` with a system image name.
    ///
    /// - Parameter appIcon: The name of the system image.
    public init(appIcon value: String) {
        self.value = value
        self.isAppIcon = true
    }
    
    /// Creates a `TabBarImageName` instance representing a system image.
    ///
    /// - Parameter systemName: The name of the system image.
    ///
    /// - Returns: A `TabBarImageName` instance.
    public static func system(_ systemName: String) -> TabBarImageName {
        return TabBarImageName(systemName: systemName)
    }
    
    /// Creates a `TabBarImageName` instance representing a app icon.
    ///
    /// - Parameter iconType: The type of the app icon.
    ///
    /// - Returns: A `TabBarImageName` instance.
    public static func appIcon(_ iconType: AppIconType) -> TabBarImageName {
        return TabBarImageName(appIcon: iconType.assetName)
    }
}

extension TabBarImageName {
    public var asUIImage: UIImage? {
        if isSystemImage {
            return UIImage(systemName: value)
        } else if isAppIcon {
            return UIImage(named: value, in: .assetsPackageModule, compatibleWith: nil)
        } else {
            return UIImage(named: value)
        }
    }
}
