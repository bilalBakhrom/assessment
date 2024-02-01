//
//  RootCoordinator.swift
//  Weather
//
//  Created by Bilal Bakhrom on 2024-02-01.
//

import UIKit
import AppBaseController
import AppSettings

public struct RootCoordinatorDependency {
    public let applicationSettings: ApplicationSettings
    public let locationManager: LocationManager
    
    public init(
        applicationSettings: ApplicationSettings,
        locationManager: LocationManager
    ) {
        self.applicationSettings = applicationSettings
        self.locationManager = locationManager
    }
}

public final class RootCoordinator: Coordinator {
    public let window: UIWindow
    public let dependency: RootCoordinatorDependency
    public var tabBarController: TabBarController?
    
    public init(window: UIWindow, dependency: RootCoordinatorDependency) {
        self.window = window
        self.dependency = dependency
    }
    
    public func start(animated: Bool = true) {
        setRootToTabBar()
    }
    
    // MARK: - Navigation
    
    public func setRootToTabBar() {
        let navigationController = BaseNavigationController()
        window.rootViewController = navigationController
        window.overrideUserInterfaceStyle = dependency.applicationSettings.userInterfaceStyle
        window.makeKeyAndVisible()
        
        let dependency = TabBarDependency(
            applicationSettings: dependency.applicationSettings,
            locationManager: dependency.locationManager
        )
        let coordinator = TabBarCoordinator(
            dependency,
            navigationController: navigationController
        )
        coordinate(to: coordinator)
    }
}
