//
//  TabBarViewModel.swift
//  Weather
//
//  Created by Bilal Bakhrom on 2024-02-01.
//

import Foundation
import AppBaseController
import AppSettings

public final class TabBarViewModel: BaseViewModel {
    public let applicationSettings: ApplicationSettings
    public let locationManager: LocationManager
    
    private let coordinator: TabBarCoordinator
    
    public init(coordinator: TabBarCoordinator) {
        self.coordinator = coordinator
        self.applicationSettings = coordinator.dependency.applicationSettings
        self.locationManager = coordinator.dependency.locationManager
    }
}
