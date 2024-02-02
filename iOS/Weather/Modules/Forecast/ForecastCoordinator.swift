//
//  ForecastCoordinator.swift
//  Weather
//
//  Created by Bilal Bakhrom on 2024-02-01.
//

import Foundation
import AppBaseController
import AppSettings
import AppNetwork

public struct ForecastDependency {
    public let applicationSettings: ApplicationSettings
    public let locationManager: LocationManager
    public let networkMonitor: NetworkReachabilityMonitor
    public let weatherRepo: WeatherRepoProtocol
    
    public init(
        applicationSettings: ApplicationSettings, 
        locationManager: LocationManager,
        networkMonitor: NetworkReachabilityMonitor,
        weatherRepo: WeatherRepoProtocol = WeatherRepo()
    ) {
        self.applicationSettings = applicationSettings
        self.locationManager = locationManager
        self.networkMonitor = networkMonitor
        self.weatherRepo = weatherRepo
    }
}

public final class ForecastCoordinator: BaseCoordinator {
    public let dependency: ForecastDependency
    
    public init(_ dependency: ForecastDependency, navigationController: BaseNavigationController) {
        self.dependency = dependency
        super.init(navigationController: navigationController)
    }
    
    public override func start(animated: Bool = true) {
        let viewModel = ForecastViewModel(coordinator: self)
        let viewController = ForecastController(viewModel: viewModel)
        
        navigationController.pushViewController(viewController, animated: animated)
    }
}
