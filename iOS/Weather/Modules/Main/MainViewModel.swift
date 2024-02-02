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
    @Published var query: String = ""
    @Published var details: WeatherDetails?
    @Published var isSearchBarActive: Bool = false
    @Published var isFetchingWeatherDetails: Bool = false
    @Published var isFetchingCities: Bool = false
    @Published var isLocationPickerPresented: Bool = false
    @Published var cities: [City] = []
    @Published var selectedCity: City?
    
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
        case fetchCities(query: String)
        case fetchWeatherDetails(location: AppCoordinates)
        case openSettings
        case onTapChange
        case onTapCity(city: City)
        case requestLocationAuthorization
        case removeSelectedCity
        case startUpdatingLocation
    }
}

// MARK: - EVENTS

@MainActor
extension MainViewModel {
    func sendEvent(_ event: ViewEvent) async {
        switch event {
        case .fetchCities(let query):
            // Handle fetching cities based on a given query string.
            await fetchCities(with: query)
            
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
            
        case .onTapChange:
            // Handle the event when the user taps to change the location manually.
            isLocationPickerPresented = true
            
        case .onTapCity(let city):
            await handleCitySelection(city)
            
        case .requestLocationAuthorization:
            // Requests authorization to access the user's location.
            locationManager.requestLocationAuthorization()
            
        case .removeSelectedCity:
            await handleCityRemoval()
            
        case .startUpdatingLocation:
            // Starts updating the user's location to provide up-to-date weather information.
            locationManager.startUpdatingLocation()
        }
    }
    
    private func handleCitySelection(_ city: City) async {
        // Handle the event when a city is selected from the list.
        // Updates the selected city, application settings, and notifies others of the selection.
        selectedCity = city
        applicationSettings.userSelectedCity = city
        NotificationCenter.default.post(appNotif: .didSelectCity, object: city)
        
        // Dismisses the location picker.
        isLocationPickerPresented = false
        
        // Clear query.
        cities = []
        query = ""
        
        // Fetch weather details for the selected city.
        await fetchWeatherDetails(lat: city.lat, lon: city.lon)
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
        
        if !networkMonitor.isReachable {
            details = applicationSettings.weatherDetails
            return
        }
        
        isFetchingWeatherDetails = true
        
        do {
            let model = RMLocation(lat: lat, lon: lon)
            let response = try await weatherRepo.fetchWeatherDetails(with: model)
            details = WeatherDetails(from: response)
            applicationSettings.weatherDetails = details
        } catch {
            reportError(error)
        }
        
        isFetchingWeatherDetails = false
    }
    
    private func fetchCities(with query: String) async {
        guard !isFetchingCities, !query.isEmpty, networkMonitor.isReachable else { return }
        
        isFetchingCities = true
        
        do {
            let model = RMGeocoding(query: query)
            let response = try await geocodingRepo.fetchCities(with: model)
            cities = response.map({ City(from: $0) })
        } catch {
            reportError(error)
        }
        
        isFetchingCities = false
    }
}
