//
//  LocationPickerViewModel.swift
//  Weather
//
//  Created by Bilal Bakhrom on 2024-02-04.
//

import Foundation
import AppBaseController
import AppNetwork
import AppModels
import AppSettings

final class LocationPickerViewModel: BaseViewModel {
    // MARK: - Properties
    
    @Published var query: String = ""
    @Published var cities: [City] = []
    @Published var selectedCity: City?
    @Published var isFetchingCities: Bool = false
    @Published var isSearchBarActive: Bool = false
    
    let applicationSettings: ApplicationSettings
    let networkMonitor: NetworkReachabilityMonitor
    
    private let coordinator: LocationPickerCoordinator
    private let geocodingRepo: GeocodingRepoProtocol
    
    // MARK: - Initialization
    
    init(coordinator: LocationPickerCoordinator) {
        self.coordinator = coordinator
        self.geocodingRepo = coordinator.dependency.geocodingRepo
        self.applicationSettings = coordinator.dependency.applicationSettings
        self.networkMonitor = coordinator.dependency.networkMonitor
    }
}

// MARK: - INTERNAL MODELS

extension LocationPickerViewModel {
    enum ViewEvent {
        case fetchCities(query: String)
        case onTapCity(city: City)
        case onTapCloseButton
    }
}

// MARK: - EVENTS

@MainActor
extension LocationPickerViewModel {
    func sendEvent(_ event: ViewEvent) async {
        switch event {
        case .fetchCities(let query):
            // Handle fetching cities based on a given query string.
            await fetchCities(with: query)
            
        case .onTapCity(let city):
            await handleCitySelection(city)
            
        case .onTapCloseButton:
            coordinator.dismiss()
        }
    }
    
    private func handleCitySelection(_ city: City) async {
        // Handle the event when a city is selected from the list.
        // Updates the selected city, application settings, and notifies others of the selection.
        applicationSettings.userSelectedCity = city
        NotificationCenter.default.post(appNotif: .didSelectCity, object: city)
        
        selectedCity = city
        
        // Clear query.
        coordinator.dismiss()
        cities = []
        query = ""
    }
}

// MARK: - NETWORK

@MainActor
extension LocationPickerViewModel {
    private func fetchCities(with query: String) async {
        guard query.count > 2, networkMonitor.isReachable else { return }
        
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
