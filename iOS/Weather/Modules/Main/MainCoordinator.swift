//
//  MainCoordinator.swift
//  Weather
//
//  Created by Bilal Bakhrom on 2024-02-01.
//

import Foundation
import AppBaseController
import AppSettings

public struct MainDependency {
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

public final class MainCoordinator: BaseCoordinator {
    public let dependency: MainDependency
    
    public init(_ dependency: MainDependency, navigationController: BaseNavigationController) {
        self.dependency = dependency
        super.init(navigationController: navigationController)
    }
    
    public override func start(animated: Bool = true) {
        let viewModel = MainViewModel(coordinator: self)
        let viewController = MainController(viewModel: viewModel)
        
        navigationController.pushViewController(viewController, animated: animated)
    }
}
