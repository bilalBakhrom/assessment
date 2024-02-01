//
//  GeocodingService.swift
//
//
//  Created by Bilal Bakhrom on 2024-02-02.
//

import Foundation
import NetworkFoundation

public protocol GeocodingServiceProtocol {
    func fetchCities(with model: RMGeocoding) async throws -> [ANCity]
}

final public class GeocodingService: ANBaseRouterService<GeocodingRouter>, GeocodingServiceProtocol {
    public func fetchCities(with model: RMGeocoding) async throws -> [ANCity] {
        try await performRequest([ANCity].self, from: .fetchCities(model: model))
    }
}

