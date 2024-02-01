//
//  TabBarItemModel.swift
//
//
//  Created by Bilal Bakhrom on 2024-02-01.
//

import UIKit

/// Represents the configuration of a tab bar item, including title and image names.
public struct TabBarItemModel {
    /// The title of the tab bar item.
    public let title: String
    
    /// The image name for the tab bar item.
    public let imageName: TabBarImageName
    
    /// The selected image name for the tab bar item.
    public let selectedImageName: TabBarImageName
    
    /// Initializes a `TabBarItemModel`.
    ///
    /// - Parameters:
    ///   - title: The title of the tab bar item.
    ///   - imageName: The image name for the tab bar item.
    ///   - selectedImageName: The selected image name for the tab bar item.
    public init(title: String, imageName: TabBarImageName, selectedImageName: TabBarImageName) {
        self.title = title
        self.imageName = imageName
        self.selectedImageName = selectedImageName
    }
}

extension TabBarItemModel {
    /// Creates a `TabBarItemModel` for a specific tab type.
    ///
    /// - Parameter tab: The type of the tab.
    /// - Returns: A `TabBarItemModel` instance.
    public static func createTabBarItem(for tab: TabItemType) -> TabBarItemModel {
        switch tab {
        case .main:
            return TabBarItemModel(
                title: "Main",
                imageName: .appIcon(.tabMain),
                selectedImageName: .appIcon(.tabMainFilled)
            )
        case .forecast:
            return TabBarItemModel(
                title: "Forecast",
                imageName: .appIcon(.tabForecast),
                selectedImageName: .appIcon(.tabForecastFilled)
            )
        }
    }
}

extension UITabBarItem {
    /// Initializes a `UITabBarItem` from a `TabBarItemModel`.
    ///
    /// - Parameter item: The `TabBarItemModel` containing configuration information.
    public convenience init(_ item: TabBarItemModel) {
        self.init(
            title: item.title,
            image: item.imageName.asUIImage,
            selectedImage: item.selectedImageName.asUIImage
        )
    }
    
    public static func createTabBarItem(for tab: TabItemType) -> UITabBarItem {
        let item = TabBarItemModel.createTabBarItem(for: tab)
        return UITabBarItem(item)
    }
}
