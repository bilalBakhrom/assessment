//
//  TabBarCoordinator.swift
//  Weather
//
//  Created by Bilal Bakhrom on 2024-02-01.
//

import Foundation
import AppBaseController
import AppSettings

public struct TabBarDependency {
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

public final class TabBarCoordinator: BaseCoordinator {
    public let dependency: TabBarDependency
    
    public init(_ dependency: TabBarDependency, navigationController: BaseNavigationController) {
        self.dependency = dependency
        super.init(navigationController: navigationController)
    }
    
    public override func start(animated: Bool = true) {
        let viewModel = TabBarViewModel(coordinator: self)
        let viewController = TabBarController(viewModel: viewModel)
        
        navigationController.pushViewController(viewController, animated: animated)
    }
}
