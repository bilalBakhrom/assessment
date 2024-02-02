//
//  TabBarViewModel.swift
//  Weather
//
//  Created by Bilal Bakhrom on 2024-02-01.
//

import Foundation
import AppBaseController
import AppSettings
import AppNetwork

public final class TabBarViewModel: BaseViewModel {
    public let applicationSettings: ApplicationSettings
    public let locationManager: LocationManager
    public let networkMonitor: NetworkReachabilityMonitor
    
    private let coordinator: TabBarCoordinator
    
    public init(coordinator: TabBarCoordinator) {
        self.coordinator = coordinator
        self.applicationSettings = coordinator.dependency.applicationSettings
        self.locationManager = coordinator.dependency.locationManager
        self.networkMonitor = coordinator.dependency.networkMonitor
    }
}
