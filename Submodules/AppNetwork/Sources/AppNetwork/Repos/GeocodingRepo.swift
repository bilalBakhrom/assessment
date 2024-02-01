//
//  Geocoding.swift
//  
//
//  Created by Bilal Bakhrom on 2024-02-02.
//

import Foundation

public protocol GeocodingRepoProtocol {
    func fetchCities(with model: RMGeocoding) async throws -> [ANCity]
}

public final class GeocodingRepo: GeocodingRepoProtocol {
    private let _service: GeocodingServiceProtocol
    
    public init(_service: GeocodingServiceProtocol = GeocodingService()) {
        self._service = _service
    }
    
    public func fetchCities(with model: RMGeocoding) async throws -> [ANCity] {
        try await _service.fetchCities(with: model)
    }
}
