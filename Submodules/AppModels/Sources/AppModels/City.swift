//
//  City.swift
//
//
//  Created by Bilal Bakhrom on 2024-02-02.
//

import Foundation
import AppNetwork

public struct City: Codable, Identifiable {
    public var id: String
    public var name: String
    public var lat: Double
    public var lon: Double
    public var country: String
    
    public init(
        name: String? = nil,
        lat: Double? = nil,
        lon: Double? = nil,
        country: String? = nil
    ) {
        self.id = UUID().uuidString
        self.name = name ?? ""
        self.lat = lat ?? 0
        self.lon = lon ?? 0
        self.country = country ?? ""
    }
    
    public init(from response: ANCity?) {
        self.init(
            name: response?.name,
            lat: response?.lat,
            lon: response?.lon,
            country: response?.country
        )
    }
    
    public init(from response: ANForecastContent.City?) {
        self.init(
            name: response?.name,
            lat: response?.coord?.lat,
            lon: response?.coord?.lon,
            country: response?.country
        )
    }
}

extension City: Hashable {}
