//
//  MainViewModel.swift
//  Weather
//
//  Created by Bilal Bakhrom on 2024-02-01.
//

import Foundation
import AppBaseController
import AppSettings

final class MainViewModel: BaseViewModel {
    @Published var showLocationDisabledAlert: Bool = false 
    
    let applicationSettings: ApplicationSettings
    let locationManager: LocationManager
    
    private let coordinator: MainCoordinator
    
    init(coordinator: MainCoordinator) {
        self.coordinator = coordinator
        self.applicationSettings = coordinator.dependency.applicationSettings
        self.locationManager = coordinator.dependency.locationManager
    }
}

// MARK: - INTERNAL MODELS

extension MainViewModel {
    enum ViewEvent {
        case requestLocationAuthorization
        case startUpdatingLocation
    }
}

// MARK: - EVENTS

@MainActor
extension MainViewModel {
    func sendEvent(_ event: ViewEvent) async {
        switch event {
        case .requestLocationAuthorization:
            locationManager.requestLocationAuthorization()
            
        case .startUpdatingLocation:
            locationManager.startUpdatingLocation()
        }
    }
}
