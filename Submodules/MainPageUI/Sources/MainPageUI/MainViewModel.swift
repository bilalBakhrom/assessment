//
//  MainViewModel.swift
//  Weather
//
//  Created by Bilal Bakhrom on 2024-02-01.
//

import UIKit
import AppFoundation
import AppBaseController
import AppSettings
import AppNetwork
import AppModels

final class MainViewModel: BaseViewModel {
    @Published var details: WeatherDetails?
    @Published var isFetchingWeatherDetails: Bool = false
    @Published var selectedCity: City?
    
    @Published var scrollOffset: CGPoint = .zero
    
    let applicationSettings: ApplicationSettings
    let locationManager: LocationManager
    let networkMonitor: NetworkReachabilityMonitor
    
    private let coordinator: MainCoordinator
    private let weatherRepo: WeatherRepoProtocol
    private let geocodingRepo: GeocodingRepoProtocol
    
    var hasSelectedCity: Bool {
        selectedCity != nil
    }
    
    init(coordinator: MainCoordinator) {
        self.coordinator = coordinator
        self.applicationSettings = coordinator.dependency.applicationSettings
        self.locationManager = coordinator.dependency.locationManager
        self.networkMonitor = coordinator.dependency.networkMonitor
        self.weatherRepo = coordinator.dependency.weatherRepo
        self.geocodingRepo = coordinator.dependency.geocodingRepo
        self.selectedCity = coordinator.dependency.applicationSettings.userSelectedCity
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
        case requestLocationAuthorization
        case removeSelectedCity
        case startUpdatingLocation
        case updateCity(city: City)
    }
}

// MARK: - EVENTS

@MainActor
extension MainViewModel {
    func sendEvent(_ event: ViewEvent) async {
        switch event {
        case .fetchWeatherDetails(let location):
            // Fetch weather details for a given location or selected city.
            if let city = selectedCity {
                await fetchWeatherDetails(lat: city.lat, lon: city.lon)
            } else {
                await fetchWeatherDetails(lat: location.lat, lon: location.lon)
            }
            
        case .openSettings:
            // Open application settings, typically to allow the user to change location permissions.
            openSettings()
            
        case .requestLocationAuthorization:
            // Requests authorization to access the user's location.
            locationManager.requestLocationAuthorization()
            
        case .removeSelectedCity:
            await handleCityRemoval()
            
        case .startUpdatingLocation:
            // Starts updating the user's location to provide up-to-date weather information.
            locationManager.startUpdatingLocation()
            
        case .updateCity(let city):
            selectedCity = city
            await fetchWeatherDetails(lat: city.lat, lon: city.lon)
        }
    }
    
    private func handleCityRemoval() async {
        // Removes the currently selected city and fetches weather details for the current location.
        selectedCity = nil
        applicationSettings.userSelectedCity = nil
        NotificationCenter.default.post(appNotif: .didSelectCity, object: nil)
        
        let location = locationManager.location
        await fetchWeatherDetails(lat: location.lat, lon: location.lon)
    }
}

// MARK: - NETWORK

@MainActor
extension MainViewModel {
    private func fetchWeatherDetails(lat: Double, lon: Double) async {
        guard !isFetchingWeatherDetails else { return }
        
        // If network is unreachable, then use cached data.
        if !networkMonitor.isReachable {
            details = applicationSettings.weatherDetails
            return
        }
        
        isFetchingWeatherDetails = true
        
        do {
            // Create a request model.
            let model = RMLocation(lat: lat, lon: lon)
            // Fetch weather details.
            let response = try await weatherRepo.fetchWeatherDetails(with: model)
            // Convert details.
            let details = WeatherDetails(from: response)
            // Cache data locally.
            applicationSettings.weatherDetails = details
            applicationSettings.isDaylight = details.isDaylight
            // Update data locally.
            self.details = details
            // Notify subscribers that app did receive weather details.
            NotificationCenter.default.post(
                appNotif: .didRequireUpdateLocationBackground,
                object: details.isDaylight
            )
        } catch {
            reportError(error)
        }
        
        isFetchingWeatherDetails = false
    }
}
