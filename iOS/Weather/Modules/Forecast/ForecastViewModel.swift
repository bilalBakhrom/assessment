//
//  ForecastViewModel.swift
//  Weather
//
//  Created by Bilal Bakhrom on 2024-02-01.
//

import Foundation
import AppBaseController
import AppSettings
import AppModels
import AppNetwork

final class ForecastViewModel: BaseViewModel {
    // MARK: - Properties
    
    @Published var isFetchingForecast: Bool = false
    @Published var content: ForecastContent?
    
    let applicationSettings: ApplicationSettings
    let locationManager: LocationManager
    let networkMonitor: NetworkReachabilityMonitor
    
    private let coordinator: ForecastCoordinator
    private let weatherRepo: WeatherRepoProtocol
    
    // MARK: - Initialization
    
    init(coordinator: ForecastCoordinator) {
        self.coordinator = coordinator
        self.applicationSettings = coordinator.dependency.applicationSettings
        self.locationManager = coordinator.dependency.locationManager
        self.networkMonitor = coordinator.dependency.networkMonitor
        self.weatherRepo = coordinator.dependency.weatherRepo
        self.content = coordinator.dependency.applicationSettings.forecastContent
    }
}

// MARK: - INTERNAL MODELS

extension ForecastViewModel {
    enum ViewEvent {
        case fetchForecastData(location: AppCoordinates? = nil)
    }
}

// MARK: - EVENTS

@MainActor
extension ForecastViewModel {
    func sendEvent(_ event: ViewEvent) async {
        switch event {
        case .fetchForecastData(let location):
            if let city = applicationSettings.userSelectedCity {
                await fetchForecastData(lat: city.lat, lon: city.lon)
            } else if let location {
                await fetchForecastData(lat: location.lat, lon: location.lon)
            }
        }
    }
}

// MARK: - NETWORK

@MainActor
extension ForecastViewModel {
    private func fetchForecastData(lat: Double, lon: Double) async {
        guard !isFetchingForecast && networkMonitor.isReachable else { return }
        isFetchingForecast = true
        
        do {
            // Create a request model.
            let model = RMForecast(lat: lat, lon: lon)
            // Fetch forecase data.
            let response = try await weatherRepo.fetchForecast(model: model)
            // Convert data.
            let content = ForecastContent(from: response)
            // Cache data.
            applicationSettings.forecastContent = content
            applicationSettings.isDaylight = content.isDaylight
            // Update local data.
            self.content = content
        } catch {
            reportError(error)
        }
        
        isFetchingForecast = false
    }
}
