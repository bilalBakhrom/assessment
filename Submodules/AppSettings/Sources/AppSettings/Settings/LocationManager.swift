//
//  LocationManager.swift
//  Weather
//
//  Created by Bilal Bakhrom on 2024-02-01.
//

import Foundation
import CoreLocation

public final class LocationManager: NSObject, ObservableObject {
    @Published public var locationStatus: CLAuthorizationStatus
    @Published public var lastLocation: CLLocation?
    @Published public var placeMark: CLPlacemark?
    @Published public var latitude: Double = 0
    @Published public var longitude: Double = 0
    
    private var locationManager: CLLocationManager
    
    public var isNotAuthorized: Bool {
        locationStatus == .denied || locationStatus == .restricted
    }
    
    public var isAuthorized: Bool {
        locationStatus == .authorizedWhenInUse || locationStatus == .authorizedAlways
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
            
            if let placeMark = self?.placeMark, let lastLocation = self?.lastLocation {
                print("PLACE: \(placeMark), lastLocation: \(lastLocation)")
            }
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
        if let location = locations.last {
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                
                latitude = location.coordinate.latitude
                longitude = location.coordinate.longitude
                lastLocation = location
            }
        }
        
        // Get location details
        if let lastLocation = lastLocation {
            fetchLocationDetails(for: lastLocation)
        }
    }
}
