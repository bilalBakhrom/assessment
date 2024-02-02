//
//  LocationManager.swift
//  Weather
//
//  Created by Bilal Bakhrom on 2024-02-01.
//

import Foundation
import CoreLocation
import AppModels

public final class LocationManager: NSObject, ObservableObject {
    @Published public var locationStatus: CLAuthorizationStatus
    @Published public var lastLocation: CLLocation?
    @Published public var placeMark: CLPlacemark?
    @Published public var location = AppCoordinates(lat: 0, lon: 0)
    
    private var locationManager: CLLocationManager
    
    public var isNotAuthorized: Bool {
        locationStatus == .denied || locationStatus == .restricted
    }
    
    public var isAuthorized: Bool {
        locationStatus == .authorizedWhenInUse || locationStatus == .authorizedAlways
    }
    
    public var country: String? {
        let locale = Locale.current
        
        if #available(iOS 16.0, *) {
            let countryCode = locale.region?.identifier
            return locale.localizedString(forRegionCode: countryCode ?? "")
        } else {
            let countryCode = locale.regionCode
            return locale.localizedString(forRegionCode: countryCode ?? "")
        }                
    }
    
    public override init() {
        let locationManager = CLLocationManager()
        self.locationManager = locationManager
        self.locationStatus = locationManager.authorizationStatus
        super.init()
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.distanceFilter = 10.0
        self.locationManager.allowsBackgroundLocationUpdates = true
    }
    
    public func requestLocationAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    public func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
    
    private func fetchLocationDetails(for location: CLLocation) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { [weak self] (placemarks, error) in
            if let error = error {
                print("Geocoding error: \(error.localizedDescription)")
                return
            }
            
            self?.placeMark = placemarks?.first
        }
    }
    
    @MainActor
    private func handleLocations(_ locations: [CLLocation]) async {
        guard let location = locations.last else { return }
        
        self.location = AppCoordinates(
            lat: location.coordinate.latitude,
            lon: location.coordinate.longitude
        )
        self.lastLocation = location
        
        // Get location details
        if let lastLocation = lastLocation {
            fetchLocationDetails(for: lastLocation)
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        locationStatus = manager.authorizationStatus
        
        if manager.authorizationStatus == .authorizedWhenInUse || manager.authorizationStatus == .authorizedAlways {
            // Authorized, start updating location
            startUpdatingLocation()
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        Task { await handleLocations(locations) }
    }
}
