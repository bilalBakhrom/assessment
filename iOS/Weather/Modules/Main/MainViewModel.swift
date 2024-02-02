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
    @Published var query: String = ""
    @Published var weatherDetails: WeatherDetails?
    @Published var isSearchBarActive: Bool = false
    @Published var isFetchingWeatherDetails: Bool = false
    @Published var isFetchingCities: Bool = false
    @Published var isLocationPickerPresented: Bool = false
    @Published var cities: [City] = []
    @Published var selectedCity: City?

    let applicationSettings: ApplicationSettings
    let locationManager: LocationManager
    
    private let coordinator: MainCoordinator
    private let weatherRepo: WeatherRepoProtocol
    private let geocodingRepo: GeocodingRepoProtocol
    private let appID = "40ac8526be74697237353948e35b0053"
    
    var hasSelectedCity: Bool {
        selectedCity != nil
    }
    
    init(coordinator: MainCoordinator) {
        self.coordinator = coordinator
        self.applicationSettings = coordinator.dependency.applicationSettings
        self.locationManager = coordinator.dependency.locationManager
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
            await fetchCities(with: query)
            
        case .fetchWeatherDetails(let location):
            if let city = selectedCity {
                await fetchWeatherDetails(lat: city.lat, lon: city.lon)
            } else {
                await fetchWeatherDetails(lat: location.lat, lon: location.lon)
            }
            
        case .openSettings:
            openSettings()
            
        case .onTapChange:
            isLocationPickerPresented = true
            
        case .onTapCity(let city):
            selectedCity = city
            applicationSettings.userSelectedCity = city
            isLocationPickerPresented = false
            cities = []
            query = ""
            await fetchWeatherDetails(lat: city.lat, lon: city.lon)
            
        case .requestLocationAuthorization:
            locationManager.requestLocationAuthorization()
            
        case .removeSelectedCity:
            selectedCity = nil
            applicationSettings.userSelectedCity = nil
            let location = locationManager.location
            await fetchWeatherDetails(lat: location.lat, lon: location.lon)
            
        case .startUpdatingLocation:
            locationManager.startUpdatingLocation()
        }
    }
}

// MARK: - NETWORK

@MainActor
extension MainViewModel {
    private func fetchWeatherDetails(lat: Double, lon: Double) async {
        guard !isFetchingWeatherDetails else { return }
        
        isFetchingWeatherDetails = true
        
        do {
            let model = RMLocation(lat: lat, lon: lon, appID: appID)
            let response = try await weatherRepo.fetchWeatherDetails(with: model)
            weatherDetails = WeatherDetails(from: response)
        } catch {
            reportError(error)
        }
        
        isFetchingWeatherDetails = false
    }
    
    private func fetchCities(with query: String) async {
        guard !isFetchingCities else { return }
        
        isFetchingCities = true
        
        do {
            let model = RMGeocoding(query: query, appid: appID)
            let response = try await geocodingRepo.fetchCities(with: model)
            cities = response.map({ City(from: $0) })
        } catch {
            reportError(error)
        }
        
        isFetchingCities = false
    }
}
