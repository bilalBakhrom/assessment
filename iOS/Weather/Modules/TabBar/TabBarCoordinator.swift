//
//  TabBarCoordinator.swift
//  Weather
//
//  Created by Bilal Bakhrom on 2024-02-01.
//

import Foundation
import AppBaseController
import AppSettings
import AppNetwork
import LocationPageUI

public struct TabBarDependency {
    public let applicationSettings: ApplicationSettings
    public let locationManager: LocationManager
    public let networkMonitor: NetworkReachabilityMonitor
    
    public init(
        applicationSettings: ApplicationSettings,
        locationManager: LocationManager,
        networkMonitor: NetworkReachabilityMonitor
    ) {
        self.applicationSettings = applicationSettings
        self.locationManager = locationManager
        self.networkMonitor = networkMonitor
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

extension TabBarCoordinator {
    func presentLocationPicker() {
        let dependency = LocationPickerDependency(
            applicationSettings: dependency.applicationSettings,
            networkMonitor: dependency.networkMonitor
        )
        
        let coordinator = LocationPickerCoordinator(
            dependency,
            navigationController: navigationController
        )
        
        coordinate(to: coordinator)
    }
}
