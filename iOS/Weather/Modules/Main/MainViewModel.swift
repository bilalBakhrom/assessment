//
//  MainViewModel.swift
//  Weather
//
//  Created by Bilal Bakhrom on 2024-02-01.
//

import UIKit
import AppBaseController
import AppSettings
import AppNetwork
import AppModels

final class MainViewModel: BaseViewModel {
    @Published var weatherDetails: WeatherDetails?
    @Published var showLocationDisabledAlert: Bool = false
    @Published var isFetchingWeatherDetails: Bool = false
    
    let applicationSettings: ApplicationSettings
    let locationManager: LocationManager
    
    private let coordinator: MainCoordinator
    private let weatherRepo: WeatherRepoProtocol
    
    init(coordinator: MainCoordinator) {
        self.coordinator = coordinator
        self.applicationSettings = coordinator.dependency.applicationSettings
        self.locationManager = coordinator.dependency.locationManager
        self.weatherRepo = coordinator.dependency.weatherRepo
    }
    
    private func openSettings() {
        guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        
        UIApplication.shared.open(settingsURL)
    }
}

// MARK: - INTERNAL MODELS

extension MainViewModel {
    enum ViewEvent {
        case fetchWeatherDetails(location: AppCoordinates)
        case openSettings
        case onTapChange
        case requestLocationAuthorization
        case startUpdatingLocation
    }
}

// MARK: - EVENTS

@MainActor
extension MainViewModel {
    func sendEvent(_ event: ViewEvent) async {
        switch event {
        case .fetchWeatherDetails(let location):
            await fetchWeatherDetails(with: location)
            
        case .openSettings:
            openSettings()
            
        case .onTapChange:
            break
            
        case .requestLocationAuthorization:
            locationManager.requestLocationAuthorization()
            
        case .startUpdatingLocation:
            locationManager.startUpdatingLocation()
        }
    }
}

// MARK: - NETWORK

@MainActor
extension MainViewModel {
    private func fetchWeatherDetails(with location: AppCoordinates) async {
        guard !isFetchingWeatherDetails else { return }
        
        isFetchingWeatherDetails = true
        
        do {
            let model = RMLocation(lat: 41.3775, lon: 64.5853, appID: "40ac8526be74697237353948e35b0053")
            let response = try await weatherRepo.fetchWeatherDetails(with: model)
            weatherDetails = WeatherDetails(from: response)
        } catch {
            reportError(error)
        }
        
        isFetchingWeatherDetails = false
    }
}
